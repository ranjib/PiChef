name 'gocd-server'
run_list %w(
  role[base]
  recipe[raspi::java]
  recipe[go_cd::server]
)
