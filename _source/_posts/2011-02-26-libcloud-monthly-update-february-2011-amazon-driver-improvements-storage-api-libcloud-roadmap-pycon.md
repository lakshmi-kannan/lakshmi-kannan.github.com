---
layout: post
title: libcloud Monthly Update (February 2011) - Amazon driver improvements, Storage API, libcloud roadmap, PyCon
published: true
tags:
  - libcloud
  - open source
  - programming
---

## [{{page.title}}][1]

February is coming to an end and here is another libcloud monthly update post.

This month has been pretty busy for me and the storage API hasn't progressed as much as I hoped, but nevertheless here is a short description of what has been going on in the past month.

<div style="text-align: center;"><a href="http://incubator.apache.org/libcloud/" target="_blank"><img src="/images/libcloud_logo.png" style="border: none !important;" align="middle"/></a></div>

<br />

### What has been accomplished in February 2011

* Amazon EC2 nodes now correctly store IP address in the Node object public_ip and private_ip attribute (previously DNS names were stored) - [r1071367][4]
* Support for listing node tags (<em>ex_describe_tags()</em>) has been added to the Amazon EC2 driver - [r1067376][9]
* Support for Elastic IP addresses has been added to the Amazon EC2 driver - [1071455][2]
* Support for adding and deleting node tags has been contributed by Brandon Rhodes and added to the Amazon EC2 driver - [r1072101][3]
* Method for listing node IP addresses (<em>ex_list_ips()</em>) has been added to the GoGrid driver - [r1067448][13]
* Support for rebuilding a node (<em>ex_rebuild()</em>) and retrieving node details (<em>ex_get_node_details()</em>) has been contributed by Andrew Klochkov and added to the Rackspace driver - [r1067451][12]

As you can see a lot of the changes are provider specific. Base libcloud API is very clear and simple to use, but a lot of users also need provider specific functionality which is in libcloud's case exposed through the extension methods (methods prefixed with <em>ex_)</em>.  

### What is currently going on

* Storage API is [under development][8] and the first alpha release of libcloud with storage support is planned to be released before PyCon (March 11th). If you check out the github repository, you can see that the [base API][10] and the [reference driver for CloudFiles][11] have already been implemented. Keep in mind that this is a development version and it is quite possible that the API will still slightly change before the final release.
* debate about libcloud road-map and plans for the future on the [mailing list][7]

<br />

### Libcloud at PyCon 2011 (March 11 - March 17)

<div style="text-align: center;"><a href="http://mail-archives.apache.org/mod_mbox/incubator-libcloud/201102.mbox/%3CAANLkTimwn5Dm372VYZ4YVcgKQqbVVwxyo8=DMFtHoTwg@mail.gmail.com%3E" target="_blank"><img src="http://us.pycon.org/2011/site_media/static/img/badges/pycon-badge-200x60.png" style="border: none !important;" align="middle"/></a></div>

<br />

Libcloud will be present at this year's [PyCon sprints][5]. This is a great opportunity for you to join us, have fun, contribute and learn something new.

Topics range from beginner to intermediate level so they are appropriate for just about anyone:

* Finishing off the Storage support
* Refactoring existing modules
* Porting it to Python 3K
* Documentation enhancements
* Improving the website (Currently, it's just a bunch of static HTML files which means it's hard to maintain it. We should port it to some kind of Python/Django based CMS).
* Setting up a new build system which hits and tests the actual provider APIs

Don't forget to post on [our mailing list][6] if you plan to join us.

Hope to see you at PyCon in Atlanta and bye until the next month!

[1]: {{ page.url }}
[2]: https://github.com/apache/libcloud/commit/20f655f458903ed36a2497b658519bef20ca20d2
[3]: https://github.com/apache/libcloud/commit/25f795d78922f45bdea9e5379cc0b6a35fcb0488
[4]: https://github.com/apache/libcloud/commit/9fb15e10c3d8c1141f531bb24dffed8ad5ba0ad0
[5]: http://us.pycon.org/2011/sprints/projects/
[6]:http://mail-archives.apache.org/mod_mbox/incubator-libcloud/201102.mbox/%3CAANLkTimwn5Dm372VYZ4YVcgKQqbVVwxyo8=DMFtHoTwg@mail.gmail.com%3E
[7]: http://mail-archives.apache.org/mod_mbox/incubator-libcloud/201102.mbox/browser
[8]: https://github.com/kami/libcloud/tree/storage_api
[9]: https://github.com/apache/libcloud/commit/a72dc0744b4df5824ef893e5be1f2b6e45c4a00c
[10]: https://github.com/Kami/libcloud/blob/storage_api/libcloud/storage/base.py
[11]: https://github.com/Kami/libcloud/blob/storage_api/libcloud/storage/drivers/cloudfiles.py
[12]: https://github.com/apache/libcloud/commit/99a6e8b89b605525da4cd1096e0e53d4fdb4d544
[13]: https://github.com/apache/libcloud/commit/104b6a41aa12b65822095d01a4195041b9e0ddfd
