package 'nagios-nrpe-server'

file '/etc/hostname' do
  content "#{node.name}\n"
  mode 0644
  owner 'root'
  group 'root'
  notifies :run, 'execute[/etc/init.d/hostname.sh]'
end

file '/etc/hosts' do
  mode 0644
  owner 'root'
  group 'root'
  content(
    [
      '127.0.0.1  localhost',
      '::1  localhost',
      "127.0.0.1  #{node.name}"
    ].join("\n")
  )
end

execute '/etc/init.d/hostname.sh' do
  action :nothing
end

remote_file '/etc/localtime' do
  source 'file:///usr/share/zoneinfo/America/Los_Angeles'
  mode 0644
  owner 'root'
  group 'root'
end

cookbook_file '/boot/config.txt' do
  mode 0755
  owner 'root'
  group 'root'
end

package 'ruby1.9.1' do
  action :remove
end

package 'utilities' do
  package_name %w(
    screen
    vim
    htop
    strace
  )
end
