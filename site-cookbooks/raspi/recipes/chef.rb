systemd_service 'chef' do
  description 'Run chef'
  exec_start '/opt/chef/bin/chef-client --no-fork'
  type 'simple'
end

systemd_timer 'chef' do
  description 'Periodic chef run'
  on_unit_active_sec '15m'
  on_boot_sec '1m'
  unit 'chef.service'
  wanted_by 'multiuser.target'
  action [:create, :start, :enable]
end
