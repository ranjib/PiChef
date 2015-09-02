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

systemd_service 'goiardi' do
  description 'Goiardi'
  user 'goiardi'
  permissions_start_only 'true'
  exec_start '/opt/goiardi/bin/goiardi -c /opt/goiardi/etc/goiardi.conf'
  restart 'always'
  restart_sec '10s'
  wanted_by 'multi-user.target'
  action [:create, :start, :enable]
end
