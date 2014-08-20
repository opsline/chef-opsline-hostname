# CHANGELOG for opsline-hostname

This file is used to list changes made in each version of the opsline-hostname cookbook.

# 1.4.0
* not using `node['cloud']['local_ipv4']`

## 1.3.0
* adding `cloudinit_preserve_hostname` attribute
* debian will write /etc/domainname file

## 1.2.0
* License change to Apache License
* Adding kitchen CI tests

## 1.1.0
* Adding use_fqdn attribute.

## 1.0.0
* Initial release of opsline-hostname.
