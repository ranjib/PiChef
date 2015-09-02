include_recipe 'sudo::default'
include_recipe 'openssh::default'

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
  source "file:///usr/share/zoneinfo/#{node.raspi.timezone}"
  mode 0644
  owner 'root'
  group 'root'
end

file '/boot/firmware/config.txt' do
  mode 0755
  owner 'root'
  group 'root'
  content(
    (node.raspi.boot_options || Raspi.default_boot_options) * "\n" + "\n"
  )
end

package 'utilities' do
  package_name %w(
    sysstat
    screen
    vim
    htop
    strace
    traceroute
  )
end
