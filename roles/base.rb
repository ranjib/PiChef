name 'base'
run_list %w(
  recipe[raspi::chef]
  recipe[raspi::utils]
)
