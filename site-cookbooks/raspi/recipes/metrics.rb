grafana_deb_url = node.raspi.metrics.grafana_deb_url
grafana_deb_path = ::File.join(Chef::Config.file_cache_path, ::File.basename(URI(grafana_deb_url).path))

package 'metrics-deps' do
  package_name %w(fontconfig-config libfontconfig1)
end

user 'influxdb' do
  system true
  home '/opt/influxdb'
  manage_home true
end

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
  source node.raspi.metrics.influxdb_url
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

remote_file grafana_deb_path do
  source grafana_deb_url
  action :create_if_missing
end

dpkg_package 'grafana' do
  source grafana_deb_path
end

service 'grafana-server' do
  action [:start, :enable]
end
