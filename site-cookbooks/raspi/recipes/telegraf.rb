remote_file '/usr/bin/telegraf' do
  owner 'root'
  group 'root'
  mode 0755
  source node.raspi.telegraf_download_url
end

user 'telegraf' do
  system true
end

template '/etc/telegraf.conf' do
  owner 'telegraf'
  group 'telegraf'
  mode 0644
  variables(
    hostname: node.name,
    database: node.raspi.telegraf_database,
    url: node.raspi.telegraf_output_url
  )
end

systemd_service 'telegraf' do
  description 'The plugin-driven server agent for reporting metrics into InfluxDB'
  documentation 'https://github.com/influxdb/telegraf'
  after 'network.target'
  user 'telegraf'
  exec_start '/usr/bin/telegraf -config /etc/telegraf.conf'
  restart 'on-failure'
  kill_mode 'process'
  wanted_by 'multi-user.target'
end
