name 'monitor'
run_list %w(
  role[base]
  recipe[raspi::monitor]
)
