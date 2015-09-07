package 'rpm'

user 'goatos' do
  home '/var/lib/go-agent'
  shell '/bin/bash'
end

execute '/opt/chef/embedded/bin/gem install fpm --no-ri --no-rdoc' do
  command '/opt/chef/embedded/bin/gem install fpm --no-ri --no-rdoc'
  not_if'/opt/chef/embedded/bin/gem spec fpm'
end

node.default['go_cd']['java_home']= '/usr/lib/jvm/java-7-oracle'
include_recipe 'raspi::java'
include_recipe 'raspi::golang'
include_recipe 'raspi::nodejs'
include_recipe 'goatos::agent'
