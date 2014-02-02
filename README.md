About
=====
this script downloads, compiles, and installs the [dnscrypt](dnscrypt.org) software that encrypts your dns queries.

This script has been written and tested for Debian, i cannot guarantte that it will work on other systems, even Debian deriviatives.

If you would like to test it in another system, make sure it has apt-get installed and it uses sysvinit for the daemon scripts to work.

Installation
============
Install dnscrypt by running the install.sh script  
`sh ./install.sh` 

Running
=======
After installation dnscrypt can be ran as a system-wide daemon by running  
`service dnscrypt start` or manually by running `/usr/local/sbin/dnscrypt-proxy`.

After you make sure that dnscrypt is running, point your computer to 127.0.0.1 as the dns server address.  
In a typical GNU/Linux system this would be done in `/etc/resolv.conf` by changing  
`nameserver dns_address` to `nameserver 127.0.0.1`  
Make sure its the only nameserver line or at least the first one in the file.

Configuration
=============
You can change the dns server and daemon options in `/etc/default/dnscrypt`.
This script uses the openNIC servers by default, since unlike openDNS, they promise to not keep query logs.
