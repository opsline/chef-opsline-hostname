node.name =~ /^([^.]+)(\.(.+))?$/
hostname = $1
domain = $3
if domain.nil?
  domain = node['hostname']['domain']

# decide what IP address will be used in the hosts file
if node['hostname']['use_ipaddress']
  host_ip = node['ipaddress']
else
  host_ip = '127.0.0.1'


# set hostname only if we can build FQDN
if hostname and domain
  fqdn = "#{hostname}.#{domain}"


  # reload ohai, but not now
  ohai 'reload' do
    action :nothing
  end


  # make hostname change permanent
  case node['platform']

  # redhat family
  when 'redhat', 'centos', 'amazon'
    hostname_string = "HOSTNAME=#{fqdn}"
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
      content "#{hostname}\n"
      mode '0644'
      notifies :reload, 'ohai[reload]', :immediate
    end

  end


  # set the hostname
  execute "hostname #{hostname}" do
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


end

