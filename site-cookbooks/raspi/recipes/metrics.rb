grafana_deb_url = 'http://'
grafana_deb_path = ::File.join(Chef::Config.file_cache_path, ::File.basename(URI(grafana_deb_url).path))

user 'influxdb' do
  system true
  home '/opt/influxdb'
  manage_home true
end

influxdb_url = 'http://10.0.0.4:8153/go/files/InfluxDB/12/Build/1/build/influxd'

cookbook_file '/etc/default/influxdb' do
  mode 0644
  source 'influxdb.sh'
end

cookbook_file '/opt/influxdb/influxdb.conf' do
  mode 0644
  owner 'influxdb'
  group 'influxdb'
end

remote_file '/opt/influxdb/influxd' do
  source influxdb_url
  mode 0755
  action :create_if_missing
end

systemd_service 'influxdb' do
  description 'InfluxDB is an open-source, distributed, time series database'
  after 'network.target'
  user 'influxdb'
  group 'influxdb'
  limit_nofile '65536'
  environment_file '-/etc/default/influxdb'
  exec_start '/opt/influxdb/influxd -config /opt/influxdb/influxdb.conf $INFLUXD_OPTS'
  restart 'on-failure'
  wanted_by 'multi-user.target'
  action [:create, :start, :enable]
end
=begin
remote_file grafana_deb_path do
  source grafana_deb_url
  action :create_if_missing
end

dpkg_package 'grafana' do
  source grafana_deb_path
end

systemd_service 'grafana' do
  action [:create, :start, :enable]
end
=end
