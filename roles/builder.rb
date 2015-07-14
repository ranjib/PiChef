name 'builder'
run_list %w(
  role[base]
  recipe[raspi::builder]
  recipe[omnibus]
)
