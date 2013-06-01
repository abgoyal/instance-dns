#! /bin/bash

# read conf file
source /etc/instance-dns.conf

# make api call
curl "$dnsmap_request_url" | tr -d "\n" >> /var/log/instance-dns.log


