---
layout: post
title: Whiskey Node.js test runner now with more goodness - introducing process runner
published: true
tags:
  - nodejs
  - open source
  - programming
  - testing
---

First a short-introduction for people who aren't familiar with Whiskey.

[Whiskey][2] is a powerful test runner for Node.js applications. It supports
async testing, code coverage, scope leaks reporting, Makefile generation,
test timing and lot more. Be sure to check out the [github page][2] which
lists all the features.

New version (0.6.0) which has been released today includes a process runner
and a support for managing external test dependencies. Test dependency is
any kind of process on which the (integration) tests depend on.

Examples include, but are not limited to:

* database,
* some kind of api server,
* web server,
* other external services

Process runner is configured using a simple JSON configuration file. Most of the
options have sane default values, which means if you don't have any special
requirements you can configure it very quickly.

Example configuration file which we use for our monitoring system integration
test suite at Rackspace can be found [here][4].

Each process can also specify its dependencies in the `depends` option which
allows Whiskey to start unrelated processes concurrently.

Before Whiskey process runner was available we have been using [scons][3] for
managing and running all the test dependencies. Test dependencies related
section in our `SConstruct` file was long and hard to maintain which means
switching to Whiskey process runner was a nice improvement.

Process runner can be used by passing `--dependencies <configuration_file_path.json>`
option to `whiskey` binary. By default all the dependencies specified in the
configuration file are started, but there is also `--only-esential-dependencies`
option available which will make Whiskey first inspect the test files and only
start the processes which are required by the tests which will be ran.

Each test file can specify on which processes it depends by exporting
`dependencies` attribute. This attribute must be an array and contain the
names of the processes as defined in the configuration file.

If you have any questions or suggestions you can find me on #Node.js IRC channel
on freenode (nick `Kami_`). If you find a bug or a problem you can also open an
ticket on the project [issue tracker][5].

[1]: {{ page.url }}
[2]: https://github.com/cloudkick/whiskey
[3]: http://www.scons.org/
[4]: https://gist.github.com/5953e55ced30ef8a9581
[5]: https://github.com/cloudkick/whiskey/issues
