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

phantomjs_url = 'https://github.com/aeberhardo/phantomjs-linux-armv6l/raw/master/phantomjs-1.9.0-linux-armv6l.tar.bz2'
phantomjs_file_path = ::File.join(Chef::Config.file_cache_path, ::File.basename(URI(phantomjs_url).path))
remote_file phantomjs_file_path do
  source phantomjs_url
  action :create_if_missing
end

execute 'decompress_phantomjs' do
  command "tar -jxvf #{phantomjs_file_path}"
  cwd Chef::Config.file_cache_path
  creates ::File.join(Chef::Config.file_cache_path, 'phantomjs-1.9.0-linux-armv6l/bin/phantomjs')
end
