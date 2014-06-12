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
* Author:: Radek Wierzbicki

```text
Copyright 2014, OpsLine, LLC.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
