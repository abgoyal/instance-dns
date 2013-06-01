install:
	cp instance-dns.conf /etc
	cp instance-dns.sh /usr/bin
	chmod +x /usr/bin/instance-dns.sh
	(crontab -l | grep -v "/usr/bin/instance-dns.sh" ; echo "@weekly /usr/bin/instance-dns.sh" ) | crontab -

