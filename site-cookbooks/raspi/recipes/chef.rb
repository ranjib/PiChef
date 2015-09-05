systemd_timer 'chef' do
  description 'Periodic chef run'
  on_unit_active_sec '15m'
  wanted_by 'timers.target'
  exec_start 'chef-client --no-fork'
end
