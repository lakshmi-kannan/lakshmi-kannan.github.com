---
layout: post
title: libcloud Monthly Update (May 2011) - 0.5.0 Release, Graduation, EuroPython
published: true
tags:
  - libcloud
  - open source
  - programming
  - apache incubator
---

## [{{page.title}}][1]

May has been a very busy and important month for us. We have finally manged to
finalize and release a long awaited version 0.5.0.

Part of the reason that we have finally managed to release 0.5.0 this month was that
me and [Paul Querna][14] were present at the Apache Retreat in Ireland where we have
spent some time hacking on Libcloud and polishing the last few features which were
missing for the release.

<div style="text-align: center;"><a href="http://libcloud.apache.org" target="_blank"><img src="/images/libcloud_logo.png" style="border: none !important;" align="middle"/></a></div>
<br />

Overall, Libcloud 0.5.0 is a big step forward and represents a big milestone for
the project. It includes many new features, improvements and new compute drivers.

### Major changes in Libcloud 0.5.0

**New cloud Storage API**

Version 0.5.0 includes a new storage API which allows you to manage services such
as Amazon S3 and Rackspace CloudFiles. Our main priority for this release was
defining a good base API and this is also the reason why this release only
includes two provider drivers.

**New Load-balancer API**

Beside cloud storage we have also added a new API for managing load-balancers
(LbaaS). Similar to the storage we were also focusing on defining a good base API
so this release only includes Rackspace and GoGrid driver.

**Changes in the existing API**

To support the new APIs and services we had to refactor the existing API which means
that all of the "compute" functionality has been moved to *libcloud.compute*.

Old module locations (libcloud.deployment, libcloud.providers, libcloud.types, etc.)
have been deprecated and will be fully removed in version 0.6.0. At the moment you
can still use them, but importing something from the old location will emit a
deprecation warning so we encourage our users to update their code to use the new
module locations.

#### New compute drivers

Among other changes and improvements, this release also includes 5 new compute
drivers:

- [Bluebox][7] (contributed by Christian Paredes)
- [Gandi.net][9] (contributed by Aymeric Barantal)
- [Nimbus][11] (contributed by David LaBissoniere)
- [OpenStack][8] (contributed by Roman Bogorodskiy)
- [Opsource.net][10] cloud (contributed by Joe Miller)

Full release announcement can be found on the [mailing list][2].

### Graduation to a Top Level Project

Second very important milestone for us this month was graduating from the Apache
Incubator to a Top Level Project. This puts us on par with other Apache projects
such as Apache Cassandra and Apache Subversion.

<div style="text-align: center;"><a href="http://apache.org/" target="_blank"><img src="/images/apache_logo.png" style="border: none !important;" align="middle"/></a></div>
<br />

Graduation signifies that both the Apache Libcloud product and community have
been well-governed under the Foundation's meritocratic, consensus-driven
process and principles.

Graduating to a Top Level Project means that now we have a
[Project Management Committee][5] (PMC) which will overlook our operations and make
sure everything is running smoothly.

To graduate we also had to select a [project chair][12]. Other members have proposed me
for this role and I have accepted it. My primary role as a project chair will be
to communicate with the board (quarterly status reports, etc.) and making sure
there aren't any conflicts and the project is running smoothly.

As part of graduation we also had to move our website and SVN repositories. You
can find all the new address in [this thread on the mailing list][13].

Official graduation announcement / press release can be found on the Apache blog -
[The Apache Software Foundation Announces Apache Libcloud as a Top-Level Project][4].

### Libcloud at EuroPython 2011 in Florence, Italy

<div style="text-align: center;"><a href="http://ep2011.europython.eu/" target="_blank"><img src="/images/europython_logo.png" style="border: none !important;" align="middle"/></a></div>
<br />

I will be at EuroPython in Italy next month where I will give an
[introductory talk about Libcloud][3].

Beside giving a talk we will also host a development sprint there. This is a
great opportunity for anyone who wants to contribute to the project or learn
something new to join us. I will post more details about the sprint in the
upcoming weeks on the [libcloud mailing list][6].

So that is it for May. See you next month when I will hopefully be able to
report about multiple new storage and compute drivers and other improvements.

[1]: {{ page.url }}
[2]: http://mail-archives.apache.org/mod_mbox/libcloud-dev/201105.mbox/%3CBANLkTi=LqBidHLHUwAJSAWSzd-qSpad+dA@mail.gmail.com%3E
[3]: http://ep2011.europython.eu/conference/talks/managing-the-cloud-with-libcloud
[4]: https://blogs.apache.org/foundation/entry/the_apache_software_foundation_announces12
[5]: http://www.apache.org/dev/pmc.html
[6]: http://libcloud.apache.org/devinfo.html
[7]: http://www.bluebox.net/
[8]: http://www.openstack.org
[9]: http://www.gandi.net
[10]: http://www.opsource.net/Services/Cloud-Hosting
[11]: http://www.nimbusproject.org/
[12]: http://www.apache.org/foundation/how-it-works.html#pmc-chair
[13]: http://mail-archives.apache.org/mod_mbox/libcloud-dev/201105.mbox/%3CBANLkTinTq7RrKpe8SMmSeKKW8yQpu-77Ew@mail.gmail.com%3E
[14]: http://paul.querna.org/
