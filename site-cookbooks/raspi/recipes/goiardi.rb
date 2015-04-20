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
    mode 0644
  end
end

remote_file '/opt/goiardi/bin/goiardi' do
  source 'https://github.com/ctdk/goiardi/releases/download/v0.9.1/goiardi-0.9.1-linux-armv7l'
  owner 'goiardi'
  group 'goiardi'
  mode 0755
  action :nothing
end

template '/opt/goiardi/etc/goiardi.conf' do
  owner 'goiardi'
  group 'goiardi'
  mode 0644
end
