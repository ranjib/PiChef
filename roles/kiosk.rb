name 'kiosk'

default_attributes(
  'raspi' => {
    'boot_options' => %w(
      arm_freq=1000
      core_freq=500
      dtparam=i2c1=on
      dtparam=i2c_arm=on
      hdmi_force_hotplug=1
      over_ voltage=2
      sdram_freq=500
    )
  }
)

run_list %w(
  role[base]
  recipe[raspi::kiosk]
)
