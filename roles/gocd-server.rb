name 'gocd-server'
run_list %w(
  role[base]
  recipe[go_cd::server]
)
