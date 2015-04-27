user 'goiardi'

%w(
  /opt/goiardi
  /opt/goiardi/data
  /opt/goiardi/conf
  /opt/goiardi/bin
  /opt/goiardi/log
  /opt/goiardi/etc
).each do |dir|
  directory dir do
    owner 'goiardi'
    group 'goiardi'
    mode 0755
  end
end

remote_file '/opt/goiardi/bin/goiardi' do
  source 'https://github.com/ctdk/goiardi/releases/download/v0.9.1/goiardi-0.9.1-linux-armv71'
  owner 'goiardi'
  group 'goiardi'
  mode 0755
  action :create_if_missing
end

template '/opt/goiardi/etc/goiardi.conf' do
  owner 'goiardi'
  group 'goiardi'
  mode 0644
  variables(hostname: node.ipaddress)
end

cookbook_file '/etc/init.d/goiardi' do
  owner 'root'
  group 'root'
  mode 0751
  source 'goiardi.init.sh'
end

service 'goiardi' do
  supports(start: true, stop: true, status: true)
  action [:start, :enable]
end
