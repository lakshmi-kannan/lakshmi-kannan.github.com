---
layout: post
title: Lessons learned while porting Libcloud to Python 3
published: true
tags:
  - libcloud
  - open source
  - programming
  - python
  - python 3
---

## [{{page.title}}][1]

Yesterday after seeing and being inspired by the [Django Python 3 port][2] news, I
have decided it's finally time to port [Libcloud][11] to Python 3. There have already been
some talks about doing that in the past, but nobody actually managed to make a
lot of progress.

In general, our goal is pretty similar to the Django one - have a single code base
which works with Python 2.5, 2.6, 2.7 / PyPy and Python 3.

Alternative approach to having a single code base is using a tool like [2to3][5]
to automatically convert 2.x version to the 3.x one or having multiple code bases
/ branches - one for 2.x and one for 3.x.

Early on when we talked about porting to Python 3, we have decided that we will go
with a "single code base" approach. This approach allows us to keep a fast development
pace and it's also more friendlier for our users.

In this post I will describe some of the issues which I have encountered while
porting the library and how I have solved them.

## 1. Handling renamed libraries and moved functionality

### httplib

In Python 3 `httplib` has been renamed to `http.client`. To solve this problem,
I have used an aliased import - `import http.client as httplib`.

### urllib & urllib2

All of the functionality from `urllib2` has been merged to `urllib`. This problem
can also be easily solved using an aliased import - `import urllib as urllib2`.

### urlparse

Functionality from `urlparse` has been moved to `urllib.parse`. We only use two
functions from this module (quote and urlencode) so simple aliased import
did the trick:

{% highlight python %}
from urllib.parse import quote as urlquote
from urllib.parse import urlencode as urlencode
{% endhighlight %}

### xmlrpclib

`xmlrpclib` has been moved to `xmlrpc.client`. Simple aliased import also
solved this problem - `import xmlrpc.client as xmlrpclib`.

### StringIO

`StringIO` has also been moved. `from io import StringIO` did the trick.

## 2. `file` type and file-like objects

`file` type has been removed in Python 3. To resolve this problem, I have used
code similar to the one bellow in the places where we use `file` type.


{% highlight python %}
if PY3:
    from io import FileIO as file

class MyFileLikeObject(file):
    ...
{% endhighlight %}

## 3. Generators and `.next()` method.

For consistency with other magic methods, `next` method in Python 3 has been
renamed to `__next__`. To make it work with all the versions, I have used built-in
`next` function in Python >= 3 and object `.next()` method in older versions.

{% highlight python %}
if sys.version_info >= (3, 0):
    next = __builtins__['next']
else:
    def next(i):
        return i.next()
{% endhighlight %}

## 4. Exception handling

Sadly, there is no unified way to handle exceptions and extract the exception
object in Python 2.5 and Python 3.x. This means I needed to use a hacky `sys.exc_info()[1]`
approach to extract the raised exception

Old code:

{% highlight python %}
try:
    foo
except Exception, e:
    print e
{% endhighlight %}

New code:

{% highlight python %}
try:
    foo
except Exception:
    e = sys.exc_info()[1]
    print e
{% endhighlight %}

One of the PyPy developers has [posted on reddit][4] that this approach is very slow
in PyPy. Luckily, besides the tests, there aren't many places in our code where we
need access to the exception object so this should be a good compromise for now.

## 5. filter, map, dict.keys()

In Python 2 those functions return a `list`, but in Python 3 they return a
special object. Compatibility can be preserved by casting a result from this
function to a list - e.g. `list(filter(lamba x: x.name == 'test', nodes))`.

## 6. iteritems, xrange

In Python 3, `iteritems` method has been removed and functionality from `xrange`
has been merged into `range`. I have simplify replaced `iteritems` with `items`
and `xrange` with `range`. We never used `xrange` with a lot of values so
storing a whole list in memory in Python 2.x shouldn't be a huge deal.

## 7. `xml.etree.ElementTree.tostring` and encoding

In Python 3 this method returns [bytes by default][9]. To preserve the old
behavior and get a string back, I have used a code similar to one bellow:

{% highlight python %}
if PY3:
    encoding = 'unicode'
else:
    encoding = None

data = tostring(root, encoding=encoding)
{% endhighlight %}

## 8. encode('hex')

We had multiple places in the code where we did something like this:

{% highlight python %}
value = os.urandom(8).encode('hex')
{% endhighlight %}

Hex encoding has been removed from Python 3. I have preserved backward
compatibility by using `binascii` module:

{% highlight python %}
value = binascii.hexlify(os.urandom(8))
{% endhighlight %}

## 9. Octal numbers

In Python 3 there is a special backward-incompatible (and strange) syntax for
octal numbers - e.g. `0o755`. We only use octal number in one place and this
has been easily resolved by using `int` to convert a string to a number with
base 8 - `int('755', 8)`.

Those are just some of the issues I have encountered during porting. If you want
to view all of the issues and how I have resolved them, you can see a full diff
[here][10].

Overall, I'm pretty satisfied with the outcome. I have managed to keep most of
the Python 2 and Python 3 compatibility code in a single module (`libcloud.py3`)
and it probably took me less then 5 hours to do the whole port including the
research.

Bellow you can also find some links which I have found helpful while porting
the code:

* [http://docs.python.org/library/2to3.html][5]
* [http://docs.python.org/release/3.0.1/whatsnew/3.0.html][6]
* [http://python3porting.com/differences.html][7]
* [http://www.voidspace.org.uk/python/articles/porting-mock-to-python-3.shtml][8]

[1]: {{ page.url }}
[2]: http://news.ycombinator.com/item?id=3305021
[4]: http://www.reddit.com/r/Python/comments/mxufx/django_python_3_port_all_tests_now_pass_on_272/
[5]: http://docs.python.org/library/2to3.html
[6]: http://docs.python.org/release/3.0.1/whatsnew/3.0.html
[7]: http://python3porting.com/differences.html
[8]: http://www.voidspace.org.uk/python/articles/porting-mock-to-python-3.shtml
[9]: http://hg.python.org/cpython/rev/57e631f088d7/
[10]: https://github.com/apache/libcloud/compare/c995ea6b8b37d4bbec741a7d2d70b08da1c62f55...py3k
[11]: http://libcloud.apache.org/
