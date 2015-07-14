name 'base'

default_attributes(
  'authorization' => {
    'sudo' => {
      'groups' => %w(),
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
