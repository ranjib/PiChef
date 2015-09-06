name 'gocd-agent'

default_attributes(
  'go_cd' => {
      'server_ip' => '10.0.0.4'
    }
)

run_list %w(
  role[base]
  recipe[raspi::gocd_agent]
)
