name 'goiardi'
run_list %w(
  role[base]
  recipe[raspi::goiardi]
)
