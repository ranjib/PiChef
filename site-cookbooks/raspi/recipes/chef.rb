systemd_service 'chef' do
  description 'Run chef'
  exec_start 'chef-client --no-fork'
end

systemd_timer 'chef' do
  description 'Periodic chef run'
  on_unit_active_sec '15m'
end
