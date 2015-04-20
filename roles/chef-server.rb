name 'chef-server'
run_list %w(
  role[base]
  recipe[raspi::goiardi]
)
