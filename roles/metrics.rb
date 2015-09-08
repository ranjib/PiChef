name 'metrics'

run_list %w(
  role[base]
  recipe[raspi::metrics]
)
