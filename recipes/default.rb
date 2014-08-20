#
# Cookbook Name:: opsline-hostname
# Recipe:: default
#
# Author:: Radek Wierzbicki
#
# Copyright 2014, OpsLine, LLC.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

node.name =~ /^([^.]+)(\.(.+))?$/
hostname = $1
domain = $3
if domain.nil?
  domain = node['opsline-hostname']['domain']
end


# decide what IP address will be used in the hosts file
host_ip = begin
  if node['opsline-hostname']['use_localhost_ip']
    '127.0.0.1'
  else
    node['ipaddress']
  end
end


# set hostname only if we can build FQDN
if hostname and domain
  fqdn = "#{hostname}.#{domain}"

  if node['opsline-hostname']['use_fqdn']
    hostname_to_set = fqdn
  else
    hostname_to_set = hostname
  end

  Chef::Log.info("Setting hostname to #{hostname_to_set}")


  # reload ohai, but not now
  ohai 'reload' do
    action :nothing
  end


  # make hostname change permanent
  case node['platform']

  # redhat family
  when 'redhat', 'centos', 'amazon'
    hostname_string = "HOSTNAME=#{hostname_to_set}"
    ruby_block 'update_sysconfig_network' do
      block do
        netfile = Chef::Util::FileEdit.new('/etc/sysconfig/network')
        netfile.search_file_replace_line('^HOSTNAME', hostname_string + "\n")
        netfile.write_file
      end
      not_if "grep -q '#{hostname_string}' /etc/sysconfig/network"
    end

  # debians and whatever else
  else
    file '/etc/hostname' do
      content "#{hostname_to_set}\n"
      mode '0644'
      notifies :reload, 'ohai[reload]', :immediate
    end
    file '/etc/domainname' do
      content "#{domain}\n"
      mode '0644'
      notifies :reload, 'ohai[reload]', :immediate
    end

  end


  # set the hostname
  execute "hostname #{hostname_to_set}" do
    only_if { node['hostname'] != hostname }
    notifies :reload, 'ohai[reload]', :immediate
  end


  # update hosts file
  hostsfile_entry 'localhost' do
   ip_address '127.0.0.1'
   hostname 'localhost'
   action :create
  end
  hostsfile_entry 'fqdn_hostname' do
    ip_address host_ip
    hostname fqdn
    aliases [ hostname ]
    action :create
    notifies :reload, 'ohai[reload]', :immediate
  end


  # set cloud init preserve_hostname parameter
  if node['opsline-hostname']['cloudinit_preserve_hostname']
    ruby_block "set cloudinit preserve hostname" do
      block do
        if File.exists?('/etc/cloud/cloud.cfg')
          file = Chef::Util::FileEdit.new('/etc/cloud/cloud.cfg')
          file.search_file_replace_line(/preserve_hostname:\s+[Ff]alse/, 'preserve_hostname: True')
          file.write_file
        end
      end
      action :run
    end
  end


else
  Chef::Log.warn("Hostname will not be set")
end
