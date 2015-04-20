link '/usr/bin/chef-client' do
  to '/opt/chef/bin/chef-client'
end

cron 'run chef' do
  command '/opt/chef/bin/chef-client'
  minute '0'
end
