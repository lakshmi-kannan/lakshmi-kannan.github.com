---
layout: post
title: Making Django and Twisted tests faster
published: true
tags:
  - programming
  - python
  - django
  - twisted
  - testing
---

## [{{page.title}}][1]

As we all know writing tests is not particularly fun and having a test suite which takes a long time to complete makes everything even less enjoyable.

Currently at Cloudkick our test suite is not particularly large or slow, but I still wanted the tests to finish faster (when dealing with tests, every minute counts).

We have two types of tests - Django and Twisted tests.

One obvious approach to speed the tests up is to run them in parallel.

A similar solution which runs the tests in parallel already exists - [multiprocessing plugin][2] for the [nose test runner][3]. The main problem with this plugin is, that it is pretty useless where a lot of tests depend on each other. Even when I have defined all the dependencies properly, the tests were still around 60% slower.

In the end, I have decided to write a custom Django and Twisted test runner which runs the tests in parallel.

Keep in mind that even before writing a custom test runner we have used a "trick" which makes the tests run faster - MySQL data directory on our continuous integration server is stored on a ram disk.

Basically our new Django test runner works like this:

1. Create a pool of worker processes
2. Partition the tests so we can run each application tests in a separate worker process
3. Put pending tests in the `pending_tests` queue
4. Each worker waits for new a new item to appear in this queue and when available, runs the tests
5. When a worker has finished running the tests, results are formatted, pickled and put in a separate `tests_results` queue
6. Main process periodically checks for new items in the `tests_results` queue and prints the results when they are available

The approach sounds pretty simple, but there are some caveats:

* because multiple processes run in parallel this means that the test output will get interleaved. The solution is to buffer each worker output and finally print it out in the main process after the worker has finished running the tests. The problem with this approach is that the output is not real-time, but it should work fine for most of the cases. If we really wanted a real-time output, I could have used a lock, but this would just add additional complexity and slow things down.

* partitioning the tests - Currently our partitioning / grouping approach is really simple, but it works well. Django tests are grouped by application and the Twisted tests are grouped by the test module. Before trying this really simple partitioning / grouping scheme I have experimented with more complicated approaches, but it turned out that in our case, simple approach is better.

* creating a separate database for each worker. Most of our Django tests manipulate the state in the database so a reasonable solution is to create a separate database for each worker. To make this work I had to override the `setup_databases()` function defined in the Django test runner class.

Because this function has changed in Django 1.3 I also had to create two separate versions - one for Django 1.2 and one for Django 1.3.

{% highlight python %}
...
def setup_databases(self, **kwargs):
  if VERSION[0] == 1:
    if VERSION[1] == 2 and VERSION[2] < 4:
      return self.setup_databases_12(**kwargs)
    elif VERSION[2] >= 4 or VERSION[1] == 3:
      return self.setup_databases_13(**kwargs)

  raise Exception('Unsupported Django Version: %s' % (str(VERSION)))

def setup_databases_12(self, **kwargs):
  # Taken from django.test.simple
  old_names = []
  mirrors = []

  worker_index = kwargs.get('worker_index', None)
  for alias in connections:
    connection = connections[alias]
    database_name = 'test_%d_%s' % (worker_index, connection.settings_dict['NAME'])
    connection.settings_dict['TEST_NAME'] = database_name
    if connection.settings_dict['TEST_MIRROR']:
      mirrors.append((alias, connection))
      mirror_alias = connection.settings_dict['TEST_MIRROR']
      connections._connections[alias] = connections[mirror_alias]
    else:
      old_names.append((connection, connection.settings_dict['NAME']))
      connection.creation.create_test_db(verbosity=0, autoclobber=not self.interactive)
  return old_names, mirrors

def setup_databases_13(self, **kwargs):
  # Taken from django.test.simple
  from django.test.simple import dependency_ordered

  mirrored_aliases = {}
  test_databases = {}
  dependencies = {}

  worker_index = kwargs.get('worker_index', None)
  for alias in connections:
    connection = connections[alias]
    database_name = 'test_%d_%s' % (worker_index, connection.settings_dict['NAME'])
    connection.settings_dict['TEST_NAME'] = database_name

    item = test_databases.setdefault(
        connection.creation.test_db_signature(),
        (connection.settings_dict['NAME'], [])
    )
    item[1].append(alias)
    if alias != DEFAULT_DB_ALIAS:
      dependencies[alias] = connection.settings_dict.get('TEST_DEPENDENCIES', [DEFAULT_DB_ALIAS])

  old_names = []
  mirrors = []
  for signature, (db_name, aliases) in dependency_ordered(test_databases.items(), dependencies):
      connection = connections[aliases[0]]
      old_names.append((connection, db_name, True))
      test_db_name = connection.creation.create_test_db(verbosity=0, autoclobber=not self.interactive)
      for alias in aliases[1:]:
          connection = connections[alias]
          if db_name:
            old_names.append((connection, db_name, False))
            connection.settings_dict['NAME'] = test_db_name
          else:
            old_names.append((connection, db_name, True))
            connection.creation.create_test_db(verbosity=0, autoclobber=not self.interactive)

  for alias, mirror_alias in mirrored_aliases.items():
    mirrors.append((alias, connections[alias].settings_dict['NAME']))
    connections[alias].settings_dict['NAME'] = connections[mirror_alias].settings_dict['NAME']

  return old_names, mirrors
...
{% endhighlight %}

I have also used a very similar approach for the Twisted parallel test runner.

As a first thing, I have created a special base class which works similar as the Django `TestCase` class - it disables database transactions in `setUp()` and does a database roll-back in the `tearDown()` method (database rollback is a lot faster than re-creating all the tables).

For the Twisted runner to buffer the test output, I had to modify the trial `_makeRunner` function and pass it in a custom stream object.

{% highlight python %}
class BufferWritesDevice(object):

  def __init__(self):
    self._data = []

  def write(self, string):
    self._data.append(string)

  def read(self):
    return ''.join(self._data)

  def flush(self, *args, **kwargs):
    pass

  def isatty(self):
    return False

....

def _tests_func(self, tests, worker_index):
  if not isinstance(tests, (list, set)):
    tests = [ tests ]

  args = [ '-e' ]
  args.extend(tests)

  config = Options()
  config.parseOptions(args)

  stream = BufferWritesDevice()
  runner = self._make_runner(config=config, stream=stream)
  suite = _getSuite(config)
  result = setup_test_db(worker_index, None, runner.run, suite)
  result = TestResult().from_trial_result(result)
  return result

...

def _make_runner(self, config, stream):
  # Based on twisted.scripts.trial._makeRunner
  mode = None
  if config['debug']:
      mode = TrialRunner.DEBUG
  if config['dry-run']:
      mode = TrialRunner.DRY_RUN
  return TrialRunner(config['reporter'],
                            mode=mode,
                            stream=stream,
                            profile=config['profile'],
                            logfile=config['logfile'],
                            tracebackFormat=config['tbformat'],
                            realTimeErrors=config['rterrors'],
                            uncleanWarnings=config['unclean-warnings'],
                            workingDirectory=config['temp-directory'],
                            forceGarbageCollection=config['force-gc'])

...
{% endhighlight %}

To make each worker use a separate database I also had to manually manipulate the connection `settings_dict` dictionary and adjust the value for the `TEST_NAME` item (I prepend worker index to each test database name).

There are still a lot of possible improvements left and some of them are already on my road-map.

Currently our number of tests and applications is not that high so it does not add much overhead to spawn a separate worker process for each application. Later on when our application number grows, it might make sense to use a smarter grouping method.

Because not all of the Django tests require access to the database, one obvious improvement would also be to spawn a separate worker process for those tests.

As I mentioned previously, our MySQL data directory is located on a ram disk so creating a database does not take that long, but every change which makes tests faster and is not too complex is worth considering.

In the end this modifications did take some time, but it was well wort it - both Django and Twisted tests now finish around **50%** - **60%** faster.

**Update: Multiple people have asked me about the full runner source code so I have
put it in Github - [https://github.com/Kami/parallel-django-and-twisted-test-runner][4].**

[1]: {{ page.url }}
[2]: http://somethingaboutorange.com/mrl/projects/nose/0.11.1/plugins/multiprocess.html
[3]: http://somethingaboutorange.com/mrl/projects/nose/1.0.0/
[4]: https://github.com/Kami/parallel-django-and-twisted-test-runner
