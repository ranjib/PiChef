
remote_file '/usr/bin/serf' do
  owner 'root'
  group 'root'
  mode 0753
  source node.raspi.serf_download_url
end

directory '/etc/serf'

file '/etc/serf/agent.json' do
  owner 'root'
  group 'root'
  mode 0644
  content node.raspi.serf_config.to_json
end

systemd_service 'serf' do
  description 'Serf Agent'
  after 'syslog.target'
  after 'network.target'
  type 'simple'
  exec_start '/usr/bin/serf agent -config-dir=/etc/serf/'
  kill_signal 'SIGINT'
  restart 'always'
  restart_sec '10'
  wanted_by 'multi-user.target'
  action [:create, :start, :enable]
end
