# C-Ares - A C library for asynchronous DNS Requests

## WTF! Asynchronous DNS requests:

Before we dive into the code-base, lets write some DNS resolver. Why? , I mean why not? 

Lets try in Python, Why? If i can code in python, then I can be 1% worth.

1st step : 

[Google](www.google.com) - x.x.x.x 

Damn that should be easy, 

	import socket
	socket.gethostbyname("www.google.com")
	
Gethostbyname() returns a struct **hostent**
	
	struct hostent{
		char  *h_name;            /* official name of host */
		char **h_aliases;         /* alias list */
		int    h_addrtype;        /* host address type */ /* AF_INET or AF_INET6 */
		int    h_length;          /* length of address */
		char **h_addr_list;       /* list of addresses */
	}
	
Hostnames are commonly referred by their symbolic names, for example, 216.58.195.69 is **mail.google.com**, and other systems in google.com refer it to as **mail**. 

###TSIG [Transaction Signature]

[rRsource](https://cira.ca/sites/default/files/usingtsig-for-zone-files-web.pdf)

TSIG is a computer network protocol used to authenticate updates to DNS database. It uses shared secret 
keys and one-way hashing to provide cryptographically secure means of authentication each end-point (Mainly
between the primary DNS server and the secondary DNS server). Communication between name servers is done
via zone files. A zone file is a text file that describes a DNS Zone, it contains the mapping between IP 
addresses and the domain names.

When any changes are made to the DNS in the primary name server it sends a “NOTIFY” DNS transaction
to the secondary. If the secondary does not have the most up to date record it requests an update using
a full zone transfer (AXFR) or an Incremental Zone Transfer (IXFR). The communication is over UDP or
TCP as a client-server transaction and as a result is generally an open communication over an unsecured
network (i.e. the Internet).

Since communication between name servers is open, authentication is critical because without it
lasting changes to the DNS can be made that IT departments would have trouble overcoming. TSIG is a
networking protocol that is defined in RFC2845 and it is used to provide authentication for dynamic DNS
updates or communication between name servers. 

###MX-record
It is a resource record which specifies mail server is responsible for accepting email messages. 

###Telephone-record 
There is a record in DNS systems to store and resolve public switched telephone network (PSTN). It is called 
E.164.

###M4 Language
M4 is a general purpose macro processor in UNIX. 
