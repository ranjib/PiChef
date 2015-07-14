include_recipe 'sudo::default'
include_recipe 'openssh::default'

# apparmor recipe bombs on 15.04
# https://github.com/opscode-cookbooks/apparmor/issues/4
unless node.platform_version == '15.04'
  include_recipe 'apparmor'
end

sudo 'ubuntu' do
  user 'ubuntu'
  nopasswd true
end

file '/etc/hostname' do
  content "#{node.name}\n"
  mode 0644
  owner 'root'
  group 'root'
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

package 'utilities' do
  package_name %w(
    screen
    vim
    htop
    strace
    traceroute
  )
end
