---
layout: post
title: Libcloud Update (April 2012) - 0.8.0, 0.9.1, GSoC
published: true
tags:
  - libcloud
  - open source
  - programming
  - google summer of code
---

## [{{page.title}}][1]

Welcome to Libcloud April 2012 update post. Sorry for skipping a couple of
months, but I have been pretty busy again. In any case, here is a short but
sweet April update.

### What has been accomplished in the past few months

* [Libcloud 0.8.1][2] with support for compressed responses (gzip, deflate) has
  been released.
* [Libcloud 0.9.1][3] with improvements in deploy functionality and OpenStack
  driver has been released.
* I have attended [PyCon US 2012][6] in Santa Clara in March. As always, it was
  a lot of fun talking with old and meeting new friends. This year we didn't
  hold a Libcloud development sprint, but I still managed to talk with some Libcloud
  users and prompted Libcloud at the AWS open space session.
* Libcloud has applied to [Google Summer of Code 2012][4] under Apache organization.
  We have received 1 slot. Student Ilgiz Islamgulov will be working on the
  [Libcloud REST interface][5] this summer.

<div class="imginline"><img src="/images/dancing_robots.jpg" class="inline"><br />Dancing robots at PyCon<br /></div>

### What is currently going on

* We are currently moving towards 1.0 release which means mostly polishing the
  code, fixing bugs and avoiding big and API breaking changes. A lot of code,
  especially compute API has already been battle tested, but there are still some
  parts which I want to see improved (deployment functionality for example) before
  releasing 1.0.

[1]: {{ page.url }}
[2]: http://mail-archives.apache.org/mod_mbox/libcloud-dev/201202.mbox/%3CCAJMHEmJJcigBO%2BZoSyxFGvc5Z37t-t3KKHBHyyMi7L-J4-Y03A%40mail.gmail.com%3E
[3]: http://mail-archives.apache.org/mod_mbox/libcloud-dev/201204.mbox/%3CCAJMHEmJzeGL%2BU1PNeX0T-1dcxUC1um88jQTAmskZ-mXTQ3QLGw%40mail.gmail.com%3E
[4]: http://www.google-melange.com/gsoc/homepage/google/gsoc2012
[5]: https://issues.apache.org/jira/browse/LIBCLOUD-159
[6]: https://us.pycon.org/2012/
