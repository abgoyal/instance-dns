#instance-dns

Scripts for mapping Cloud Instance names to DNS

## Introduction

These scripts make it easy and effortless to assign DNS names to your cloud instances at launch.
Cloud providers like Digital Ocean, Upcloud etc require an account-unique name to be assigned to
a new instance at launch, but do not automatically map this name to the instance IP using a DNS A record. 

In theory, one could solve this problem by installing ddclient and creating an account at one of the many 
Dynamic DNS providers, this doesn't really work:

* Dynamic DNS is meant for low-TTL situations, where IP might change unpredictably and quickly. This is true for
a server on a home DSL/Cable connection but not true for a cloud instance.  A cloud instance gets assigned a new IP
at launch and retains it untill it is destroyed. Also, having a low-TTL unnecessarily reduces the benefits of DNS resolver caches.

* Hardly any of the dynamic dns providers allow creating a new name via API. The API is designed to allow only for updating the
IP associated with a pre-existing A-record, and not for creation of entirely new A-records. This means every time one launches 
an additional instance, with an as-yet-unconfigured name, this name must first be added to the Zone manually using the DNS panel.

## Instance DNS

Instance DNS comes with preconfigured set of DNS providers that have APIs fully capable of adding new A-records. Currently there is support for:

* Zonomi

Also, Instance DNS works at boot-time, updates the zone records once, and then quits. This behaviour is perfect for a cloud instance 
where no dynamic change of IP occurs, and thus there is no need to have an additional deamon running, monitoring for IP change.

## Installation

From within a new instance:

* Clone the repository

git clone git://github.com/abgoyal/instance-dns.git
cd instance-dns

* Edit configuration

vi instance-dns.conf

** At the very least you must change the base domain: Change it to a domain you own

** You must also configure the required details for your DNS provider. In the case of Zonomi, for example, you need to update your own API key.

* Install

sudo make install

** This simply copies the config file to /etc, the script to /usr/bin, and adds the script to crontab, to be executed at boot.

* Bake this instance into a template/image/AMI/equivalent/backup as per the requirements of your cloud provider. 
Use this to launch as many instances as you want. Instance Dns will take the hostname assigned by the cloud provider at boot, and map it as a subdomain 
to the base domain you configured in the config file.

