---
layout: post
title: Hosting APT repository on Rackspace CloudFiles
published: true
tags:
  - open source
  - programming
  - libcloud
  - apt
---

## [{{page.title}}][1]

In this post I will describe how to host APT repository on
[Rackspace Cloud Files][4].

First you need to create a CDN enabled container. You can do this using
Libcloud or the new [Rackspace control panel][3]. Depending on how frequently
you are going update your APT repository it is also recommended to lower the
container TTL from the default value of 3 days to 900 seconds.

After you have created a CDN enabled container you need to install Python script
I wrote which allows you to sychronize files from a local directory to a container
hosted in one of the Storage providers [supported by Libcloud][2].

{% highlight console %}
  sudo pip install file-syncer
{% endhighlight %}

Next we are going to create a dummy APT repository::

{% highlight console %}
mkdir -p /tmp/apt-test/conf
cat > /tmp/apt-test/conf/distributions <<DELIM
codename: precise
Components: main
Architectures: i386 amd64
DELIM
{% endhighlight %}

Add a test package using `reprepro`:

{% highlight console %}
wget http://us.archive.ubuntu.com/ubuntu/ubuntu/ubuntu/pool/main/a/acpi/acpi_0.09-3ubuntu1_amd64.deb
reprepro -b /tmp/apt-test/ includedeb precise acpi_0.09-3ubuntu1_amd64.deb
{% endhighlight %}

And test the script:

{% highlight console %}
file-syncer --log-level=DEBUG --directory=/tmp/apt-test/ --username=your username --key=your api key --container-name=container name
{% endhighlight %}

If everything went well, you should see an output similar to this one:

{% highlight console %}
22 Jul 2012 22:36:05 : INFO     : Using provider: CloudFiles (US)
22 Jul 2012 22:36:07 : DEBUG    : Found 15 local files
22 Jul 2012 22:36:08 : DEBUG    : Manifest doesn't exist, assuming that there are no remote files
22 Jul 2012 22:36:08 : DEBUG    : Found 0 remote files
22 Jul 2012 22:36:08 : INFO     : To remove: 0, to upload: 15
22 Jul 2012 22:36:08 : DEBUG    : Uploading object: db/contents.cache.db
22 Jul 2012 22:36:08 : DEBUG    : Uploading object: dists/precise/main/binary-amd64/Packages
22 Jul 2012 22:36:08 : DEBUG    : Uploading object: dists/precise/main/binary-i386/Release
22 Jul 2012 22:36:08 : DEBUG    : Uploading object: dists/precise/main/binary-i386/Packages
22 Jul 2012 22:36:08 : DEBUG    : Uploading object: db/packages.db
22 Jul 2012 22:36:08 : DEBUG    : Uploading object: pool/main/a/acpi/acpi_0.09-3ubuntu1_amd64.deb
22 Jul 2012 22:36:08 : DEBUG    : Uploading object: db/release.caches.db
22 Jul 2012 22:36:08 : DEBUG    : Uploading object: db/version
22 Jul 2012 22:36:08 : DEBUG    : Uploading object: conf/distributions
22 Jul 2012 22:36:08 : DEBUG    : Uploading object: db/references.db
22 Jul 2012 22:36:09 : DEBUG    : Object uploaded: dists/precise/main/binary-amd64/Packages
22 Jul 2012 22:36:09 : DEBUG    : Uploading object: dists/precise/main/binary-i386/Packages.gz
22 Jul 2012 22:36:09 : DEBUG    : Object uploaded: dists/precise/main/binary-i386/Packages
22 Jul 2012 22:36:09 : DEBUG    : Uploading object: dists/precise/main/binary-amd64/Packages.gz
22 Jul 2012 22:36:09 : DEBUG    : Object uploaded: db/release.caches.db
22 Jul 2012 22:36:09 : DEBUG    : Uploading object: db/checksums.db
22 Jul 2012 22:36:09 : DEBUG    : Object uploaded: dists/precise/main/binary-i386/Release
22 Jul 2012 22:36:09 : DEBUG    : Uploading object: dists/precise/main/binary-amd64/Release
22 Jul 2012 22:36:09 : DEBUG    : Object uploaded: conf/distributions
22 Jul 2012 22:36:09 : DEBUG    : Uploading object: dists/precise/Release
22 Jul 2012 22:36:09 : DEBUG    : Object uploaded: db/packages.db
22 Jul 2012 22:36:09 : DEBUG    : Object uploaded: db/contents.cache.db
22 Jul 2012 22:36:09 : DEBUG    : Object uploaded: db/references.db
22 Jul 2012 22:36:09 : DEBUG    : Object uploaded: db/version
22 Jul 2012 22:36:09 : DEBUG    : Object uploaded: pool/main/a/acpi/acpi_0.09-3ubuntu1_amd64.deb
22 Jul 2012 22:36:10 : DEBUG    : Object uploaded: dists/precise/main/binary-amd64/Packages.gz
22 Jul 2012 22:36:10 : DEBUG    : Object uploaded: dists/precise/main/binary-i386/Packages.gz
22 Jul 2012 22:36:10 : DEBUG    : Object uploaded: db/checksums.db
22 Jul 2012 22:36:10 : DEBUG    : Object uploaded: dists/precise/Release
22 Jul 2012 22:36:10 : DEBUG    : Object uploaded: dists/precise/main/binary-amd64/Release
22 Jul 2012 22:36:11 : INFO     : Synchronization complete, took: 4.62 seconds
{% endhighlight %}

After the upload has finished, you can test the repository by adding it to your
APT sources list:

{% highlight console %}
  echo "deb http://c15173579.r79.cf2.rackcdn.com precise main" | sudo tee -a /etc/apt/sources.list.d/test-api-repo.list
{% endhighlight %}

We are also going to disable APT HTTP request pipeling. This step is required,
because a nginx proxy running in front of the CDN doesn't seem to support
HTTP/1.1 pipelining. If you skip this test apt-get update will still work, but
it will get stuck on `[Waiting for headers]` for a longer period of time.

{% highlight console %}
  echo "Acquire::http::Pipeline-Depth "0";" | sudo tee -a /etc/apt/apt.conf.d/pipeline-workaround.conf
{% endhighlight %}

You can test that everything is working by issuing the following command:

{% highlight console %}
  sudo apt-get update ; sudo apt-cache policy acpi
{% endhighlight %}

You should get an output similar to this one:

{% highlight console %}
acpi:
  Installed: (none)
  Candidate: 1.6-1
  Version table:
     1.6-1 0
        500 http://us.archive.ubuntu.com/ubuntu/ precise/universe amd64 Packages
     0.09-3ubuntu1 0
        500 http://c15173579.r79.cf2.rackcdn.com/ precise/main amd64 Packages
{% endhighlight %}

That is it. To make sure your container is always up to date, you need
synchronize it every time you add a new packages. This can be achieved in
multiple ways:

* adding a script which runs synchronize command after adding a package
* adding a cron job which periodically runs the sync command

[1]: {{ page.url }}
[2]: http://libcloud.apache.org/supported_providers.html
[3]: https://mycloud.rackspace.com
[4]: http://www.rackspace.com/cloud/cloud_hosting_products/files/
