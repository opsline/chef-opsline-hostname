opsline-hostname Cookbook
=========================
This cookbook sets the hostname of the node.


Requirements
------------
#### cookbooks
- `hostsfile` - provides an LWRP for managing your `/etc/hosts`


Attributes
----------
* `node['opsline-hostname']['domain']`
domain to be used if node name is not FQDN
* `node['opsline-hostname']['use_localhost_ip']`
if true, `127.0.0.1` will be used in `/etc/hosts`
* `node['opsline-hostname']['use_fqdn']`
if true, hostname will be set to FQDN; if false, only node name will be used


Usage
-----
#### opsline-hostname::default
Include early in the runlist to set the hostname properly.

Hostname will be based on the node name.

* if the nodename is a FQDN, it will be parsed to get host name and domain name 
to set the hostname.
* if the nodename is a not FQDN, the domain must be provided with an attribute.
* either nodename as FQDN, or nodename plus a domain attrubute are necessary
for hostname to be set.
* by default, hostname will be set to FQDN. Setting `use_fqdn` attribute to false
will cause hostname to be the nodename string.


License and Authors
-------------------
Authors: Radek Wierzbicki (OpsLine)
