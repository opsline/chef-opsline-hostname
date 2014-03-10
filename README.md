opsline-hostname Cookbook
=========================
This cookbook sets the hostname of the node.


Requirements
------------
#### packages
- `hostsfile` - provides an LWRP for managing your `/etc/hosts`


Attributes
----------
* `node['hostname']['domain']` - domain to be used if node name is not FQDN
* `node['hostname']['use_ipaddress']` - if true, `ipaddress` will be used in `/etc/hosts`


Usage
-----
#### opsline-hostname::default
Include early in the runlist to set the hostname properly.


License and Authors
-------------------
Authors: Radek Wierzbicki (OpsLine)
