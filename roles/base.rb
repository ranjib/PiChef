name 'base'

default_attributes(
  'authorization' => {
    'sudo' => {
      'include_sudoers_d' => true
    }
  },
  'apparmor' => {
    'disable' => false
  }
)

run_list %w(
  recipe[raspi::base]
  recipe[raspi::chef]
)
