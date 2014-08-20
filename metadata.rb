name             'opsline-hostname'
maintainer       'OpsLine'
maintainer_email 'radek@opsline.com'
license          'All rights reserved'
description      'Configures hostname'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.4.0'

supports 'redhat'
supports 'amazon'
supports 'centos'
supports 'debian'
supports 'ubuntu'

depends 'hostsfile'
