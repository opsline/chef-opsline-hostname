opsline-hostname Cookbook
=========================
This cookbook sets the hostname of the node.


Requirements
------------
#### cookbooks
- `hostsfile` - provides an LWRP for managing your `/etc/hosts`


Attributes
----------
* `node['opsline-hostname']['domain']` - domain to be used if node name is not FQDN
* `node['opsline-hostname']['use_localhost_ip']` - if true, `127.0.0.1` will be used in `/etc/hosts`


Usage
-----
#### opsline-hostname::default
Include early in the runlist to set the hostname properly.


License and Authors
-------------------
Authors: Radek Wierzbicki (OpsLine)
