---
layout: post
title: libcloud Monthly Update (April 2011) - Storage API, load-balancer API, new drivers
published: true
tags:
  - libcloud
  - open source
  - programming
---

## [{{page.title}}][1]

Another month is around and it is time for another libcloud monthly update post. I did not write one previous month, because I have written "[PyCon US 2011 Recap][2]" post which also includes information about libcloud development which has happened during PyCon and in March.

<div style="text-align: center;"><a href="http://incubator.apache.org/libcloud/" target="_blank"><img src="/images/libcloud_logo.png" style="border: none !important;" align="middle"/></a></div>

<br />

### What has been accomplished in April 2011

* libcloud website has been ported to the Apache CMS. Now adding new and editing existing content should be a lot easier.
* Extension method for modifying the instance attributes and changing the instance size has been added to the Amazon compute driver - [r1084180][3]
* Gandi.net compute driver has been contributed by Aymeric Barantal - [LIBCLOUD-76][4]
* CloudFiles storage driver and the base storage class have undergone a lot of improvements
* CloudFiles storage driver [code coverage][5] has been increased for ~20% (from ~70% to ~89)
* A new Amazon S3 storage driver has been committed intro trunk - [s3.py][6]
* OpSource compute driver has been contributed by Joe Miller - [LIBCLOUD-77][7]
* Work has started on the load-balancer API and a reference drivers for GoGrid and Rackspace have already been committed into trunk. [r1095180][8]
* [Community resources][9] section has been added to the website. This section contains links to different articles, tutorials and presentations produced by the libcloud developers and users.

### What is currently going on

* Jeremy Whitlock is working on the [libvirt][10] driver. If you have any feedback or suggestions for this driver, please share it with others on the [mailing list][11].
* Work continues on the storage and the load-balancer API. Only some minor changes are still needed for the storage API to be considered stable enough so libcloud 0.5.0 can be released.

### Misc

* Roman (the main author of the libcloud load-balancer API) has written a blog
  post which describes some differences and caveats which you can encounter while
  working with the Rackspace and GoGrid load-balancer API so be sure to check it out -
  [Overview of GoGrid and Rackspace Load Balancing Services][12].


As you can see, April was pretty busy and a lot of new stuff has been committed into trunk.

Storage API will hopefully be finished soon and one of the highlights of the next month update post will be a long-awaited libcloud 0.5.0 release :)

[1]: {{ page.url }}
[2]: /2011/03/18/pycon-us-2011-recap.html
[3]: https://github.com/apache/libcloud/commit/dc9ccd87a44399ec9fa4c1982c0fc91859a305f1
[4]: https://issues.apache.org/jira/browse/LIBCLOUD-76
[5]: http://ci.apache.org/projects/libcloud/coverage/libcloud_storage_drivers_cloudfiles.html 
[6]: https://github.com/apache/libcloud/blob/trunk/libcloud/storage/drivers/s3.py
[7]: https://issues.apache.org/jira/browse/LIBCLOUD-77
[8]: https://github.com/apache/libcloud/commit/cf8b90c3a9eb0cc5659ce71b40883e6e67581aad
[9]: http://incubator.apache.org/libcloud/community-resources.html
[10]: http://libvirt.org/
[11]: http://mail-archives.apache.org/mod_mbox/incubator-libcloud/201104.mbox/%3CFA4867B9-0BFF-4F7C-84D9-CF342632446A@gmail.com%3E
[12]: http://empt1e.blogspot.com/2011/04/comparison-of-gogrid-and-rackspace-load.html
