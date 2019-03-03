# samplicator_docker
A Docker Container for Samplicator (https://github.com/sleinen/samplicator)

Samplicator can be used to forward UDP packets to multiple destinations.

# Usage
The usage convention for samplicator is...

```
$ sudo docker run -it --network host robcowart/samplicator:1.0.0_1.3.8rc1 [<option>...] [<destination>...]
```

The allowed `<option>`s are...

Option | Description
---|---
`-d <level>` | to set the debugging level
`-s <address>` | to set interface address on which to listen for incoming packets (default any)
`-p <port>`	| to set the UDP port on which to listen for incoming packets (default 2000)
`-b <buflen>` | size of receive buffer (default 65536)
`-c <configfile>` | specify a config file to read
`-x <delay>` | to specify a transmission delay after each packet, in units of	microseconds
`-S` | maintain (spoof) source addresses
`-n` | don't compute UDP checksum (only relevant with -S)
`-f` | fork program into background
`-m <pidfile>` | write the process ID to a file
`-4` | IPv4 only
`-6` | IPv6 only
`-h` | to print a usage message and exit
`-u <pdulen>`	| size of max pdu on listened socket (default 65536)

Each `<destination>` should be specified as `<addr>[/<port>[/<interval>[,ttl]]]`, where...

Parameter | Description
---|---
`<addr>` | IP address of the receiver
`<port>` | port UDP number of the receiver (default 2000)
`<freq>` | number of received datagrams between successive copied datagrams for this receiver.
`<ttl>` | The TTL (IPv4) or hop-limit (IPv6) for outgoing datagrams.

Config file format:

    a.b.c.d[/e.f.g.h]: receiver ...

where:

	a.b.c.d     is the sender's IP address
    e.f.g.h     is a mask to apply to the sender (default 255.255.255.255)
    receiver    see above.

Receivers specified on the command line will get all packets, those
specified in the config-file will get only packets with a matching
source.

# Starting Samplicator with docker-compose
The included `docker-compose.yml` file provides examples of using samplicator to forward Netflow, IPFIX, sFlow, Syslog and SNMP Traps.

# License
The code to build and run samplicator as a container is released under Apache License Version 2.0, January 2004.

Samplicator itself is released under GNU General Public License v2.0.
