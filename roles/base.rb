name 'base'
run_list %w(
  recipe[raspi::base]
  recipe[raspi::chef]
)
