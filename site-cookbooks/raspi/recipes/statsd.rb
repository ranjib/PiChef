metrics_end_point = node.raspi.metrics_end_point
remote_file '/usr/bin/statsdaemon' do
  owner 'root'
  group 'root'
  mode 0753
  source node.raspi.statsdaemon_download_url
end

systemd_service 'statsdaemon' do
  description 'Statsdaemon - StatsD endpoint'
  after 'syslog.target'
  after 'network.target'
  type 'simple'
  exec_start "/usr/bin/statsdaemon -graphite=#{metrics_end_point}"
  kill_signal 'SIGINT'
  restart 'always'
  restart_sec '10'
  wanted_by 'multi-user.target'
  action [:create, :start, :enable]
end
