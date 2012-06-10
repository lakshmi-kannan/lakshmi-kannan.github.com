---
layout: post
title: Libcloud Monthly Update (December 2011) - 0.6.1, 0.6.2, 0.7.1, Python 3
published: true
tags:
  - libcloud
  - open source
  - programming
---

## [{{page.title}}][1]

Past few months have been pretty busy here and you may have noticed that I didn't
post a monthly update post in the last two months. This doesn't mean nothing has
been going on though! In fact, quite the contrary. Last few months have been very
busy and we have shipped two new releases and a voting thread for a new 0.7.1 release
was just started a few days ago. More about that bellow.

### What has been accomplished in the past two months

* [Libcloud 0.6.1][2] with a brand new DNS API (among many other improvements
  and additions) has been released.
* A few days after releasing 0.6.1 we have also released [0.6.2][3] which was primary
  a bug-fix release, but it also includes some new features and improvements
  such as support for OpenStack Auth 2.0 API, support for new Amazon location
  (Oregon) and a CloudStack driver.
* A few weeks ago a new committer, Hutson Betts (hbetts) has [joined our team][4]. He
  has previously mostly contributed to the OpenNebula driver and we believe
  giving him commit access will allow him to contribute more directly and easily
  and is a good thing for the whole project.

### What is currently going on

* A lot of things!
* This weekend I have just finished adding support for Python 3 to Libcloud. Now
  we have a single code base which supports both, Python 2 and 3 and as far as I know
  we are the first Python cloud library which does that. I hope other projects
  will follow.
  If you are interested in more details you can read my post titled
  [Lessons learned while porting Libcloud to Python 3][5] where I have
  described some of the issues which I have encountered while porting the library.
  Armin has recently also wrote a good blog post about Python 3 which you should
  read - [Thoughts on Python 3][6].
* I am moving to San Francisco where I will work full time for Rackspace. I will
  try to organize a Bay Area Libcloud meet-up in the upcoming weeks (hey, free pizza
  and beer!). I will post more info on the website and mailing list when all the 
  details are fleshed out.

[1]: {{ page.url }}
[2]: http://mail-archives.apache.org/mod_mbox/www-announce/201111.mbox/%3CCAJMHEm+8XX704mSY4qw4P0YSBjGK=0SWCKjzSHBe8sLD__2UnA@mail.gmail.com%3E
[3]: http://mail-archives.apache.org/mod_mbox/libcloud-users/201111.mbox/%3CCAJMHEmJTN407_JJRfnwDuJxNsWCupEGc0cXWxs=M-n8HoHoQKQ@mail.gmail.com%3E
[4]: http://mail-archives.apache.org/mod_mbox/libcloud-dev/201111.mbox/%3CCAJMHEm+08-1MMCgHDZgULc+StDiwgR+_krVZvHOJF0odcU_OWg@mail.gmail.com%3E
[5]: /2011/12/03/lessons-learned-while-porting-libcloud-to-python-3.html
[6]: http://lucumr.pocoo.org/2011/12/7/thoughts-on-python3/
