---
layout: post
title: libcloud Monthly Update (January 2011) - libcloud 0.4.2, Storage API, Pycon
published: true
tags:
  - libcloud
  - open source
  - programming
---

## [{{page.title}}][1]

Recently I have joined the libcloud team as a committer and I have decide to write a short status update post each month (actually, [Redis weekly][11] has inspired me to post something like this - our posts won't be so low-level but more of a general view of what's going on with the project).

<div style="text-align: center;"><a href="http://incubator.apache.org/libcloud/" target="_blank"><img src="/images/libcloud_logo.png" style="border: none !important;" align="middle"/></a></div>

The post will summarize what was accomplished in the previous month, what is currently going on and what you can expect in the upcoming months.

I am going to start with an update for the January 2011.

### What has been accomplished in January 2011:

* libcloud is back to Twitter, new account name is [@libcloud][15]
* libcloud **0.4.2** has [finally been released][2], some notable features are:
* new drivers for [CloudSigma][3], [Brightbox][4] and [Rackspace UK][5]
* availability zone support for the EC2 driver - now you can select an availability zone when booting an EC2 node
* improvements to deployment capabilities
* libcloud.security module for SSL certificate verification - actually it's pretty sad that we needed to implement this ourselves, but since Python 2.5 / Python 2.6 does not provide this functionality, this was our only option (actually, we could use a library like [M2Crypto][16], but we don't want to introduce another external dependency). For more information about setting it up, read [this wiki entry][6] and [this blog post][7].
* Minimum supported version has changed from Python 2.4 to Python 2.5

<br />

### What is currently going on:

*  cluster instance support has been [added to the EC2 driver][8] - that is not really a killer feature, but it's still a nice to have :-)
* debate about the ["driver maintainer status" on the mailing list][14]
* hacking has started on the Storage API ([libcloud storage API proposal & ideas thread][9], [wiki entry][10]) - this is a pretty major feature so you are encouraged to join our mailing list and participate with your ideas, feedback and suggestions

<br />

Library will eventually be split into two modules; "**compute**" (current drivers and deployment capabilities will be moved there) and "**storage**" (in development) - don't worry, we are working hard to not break the existing functionality so you will still be able to use your old code with a new version without any major changes.

This feature is planned to be included in the next release of libcloud (**0.5.0**).

### What is going on in the upcoming months:

* Me (Tomaz), [Paul][12] and [Jerry][13] will be at [Pycon][17] in March so if you will be there as well, feel free to contact us, we'd love to talk!

<br />

That is it, see you next month (in the mean time, don't forget to join us at our mailing lists - **libcloud@incubator.apache.org** or IRC channel **#libcloud @ freenode**).

[1]: {{ page.url }}
[2]: http://mail-archives.apache.org/mod_mbox/incubator-libcloud/201101.mbox/%3C9A2A5D8D-423C-42B2-94AA-606489483FA3@apache.org%3E
[3]: http://cloudsigma.com/
[4]: http://www.brightbox.co.uk/
[5]: http://www.rackspacecloud.co.uk
[6]: http://wiki.apache.org/incubator/LibcloudSSL
[7]: http://agiletesting.blogspot.com/2011/01/libcloud-042-and-ssl.html
[8]: https://svn.apache.org/viewvc/incubator/libcloud/trunk/libcloud/drivers/ec2.py?r1=1056498&r2=1062725&diff_format=h
[9]: http://mail-archives.apache.org/mod_mbox/incubator-libcloud/201101.mbox/%3CAANLkTi=3Ct8fTMkTSFChTk_tEP0+1TiCfZ_4azUxE8xs@mail.gmail.com%3E
[10]: http://wiki.apache.org/incubator/LibcloudStorageAPI
[11]: http://antirez.com/post/redis-weekly-update-1.html
[12]: http://journal.paul.querna.org/
[13]: http://twitter.com/#!/jcsalterego
[14]: http://mail-archives.apache.org/mod_mbox/incubator-libcloud/201101.mbox/%3CAANLkTi=g=4iBw2etBxJ1FYCwitnj_ZZFtmz=5ij5+pEX@mail.gmail.com%3E
[15]: http://twitter.com/#!/libcloud
[16]: http://wiki.python.org/moin/M2Crypto
[17]: http://us.pycon.org/2011/about/
