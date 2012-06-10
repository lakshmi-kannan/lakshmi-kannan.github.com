---
layout: post
title: libcloud Monthly Update (September 2011) - FLOSS weekly, OpenStack driver improvements, DNS API
published: true
tags:
  - libcloud
  - open source
  - programming
  - floss weekly
---

## [{{page.title}}][1]

Without further ado here is a Libcloud monthly update for September 2011.

### What has been accomplished in the past month

* I was a guest on FLOSS weekly (podcast about FOSS software) where I talked about
  Libcloud. You can find video and audio recording of the show on [twit.tv][2].

* OpenStack and Rackspace drivers have received a lot of needed attention and
  refactoring. Rackspace driver now properly inherits from the OpenStack one
  instead of vice versa (thanks [Mike][8]). This will make extending the Rackspace
  driver and developing other provider drivers which are based on OpenStack a lot
  easier. Rackspace drivers now also support authentication with Rackspace Auth
  1.1.

* Linode compute driver now supports new location in Japan.

  Linode has recently [added a new location (Tokyo, Japan)][6] and this location is
  now also [supported in Libcloud][6].

* DNS API development has finally started.

  Base API proposal can be found [here][3]. I have also just finished a reference
  implementation and a first driver for the Linode DNS as a service.
  The driver can be found in [trunk][4]. Feedback is [welcome (and encouraged)][5].


### What is currently going on

* Hacking on the DNS API continues. DNS API with at least two drivers is planned
  to be included in the next release (0.6.0) which should be out around November.

See you next month!

[1]: {{ page.url }}
[2]: http://twit.tv/show/floss-weekly/181
[3]: http://mail-archives.apache.org/mod_mbox/libcloud-dev/201109.mbox/%3CCAJMHEmLfWki5awUqZL9ZNsrpJFkHNHAe00Vs5SeaJXkmWSxJ7g@mail.gmail.com%3E
[4]: https://svn.apache.org/viewvc/libcloud/trunk/libcloud/dns/drivers/linode.py?view=markup
[5]: http://mail-archives.apache.org/mod_mbox/libcloud-dev/201109.mbox/%3CCAJMHEmL7M12TG5eFz0HQ-kCuA3=ZnNkTt8_veoOFNfueaG9q2w@mail.gmail.com%3E
[6]: http://blog.linode.com/2011/09/19/linode-cloud-asia-pacific/
[7]: https://svn.apache.org/viewvc/libcloud/trunk/libcloud/compute/drivers/linode.py?r1=1172808&r2=1172807&pathrev=1172808
[8]: https://issues.apache.org/jira/secure/ViewProfile.jspa?name=manganeez
