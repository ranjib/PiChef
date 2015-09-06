execute 'curl -sL https://deb.nodesource.com/setup_0.12 | bash -' do
  not_if 'dpkg -l | grep nodejs'
end

package 'nodejs' do
  notifies :run, 'execute[install_grunt_cli]'
end

execute 'install_grunt_cli' do
  command 'npm install -g grunt-cli'
  action :nothing
end
