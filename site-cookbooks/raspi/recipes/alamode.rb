package 'arduino' do
  package %w(
    arduino
    avr-libc
    libftdi1
    avrdude
    openjdk-6-jre
    librxtx-java
  )
end
package 'i2c-tools'

directory '/opt/alamode'

remote_package '/opt/alamode/alamode-setup.tar.gz' do
  source 'https://github.com/wyolum/alamode/raw/master/bundles/alamode-setup.tar.gz'
  action :create_if_missing
end

execute 'tar -xvzf alamode-setup.tar.gz' do
  cwd '/opt/alamode'
  creates '/opt/alamode/alamode-setup/setup'
  notifies :run, 'bash[alamode_setup]'
end

bash 'alamode_setup' do
  code 'sudo ./setup'
  cwd '/opt/alamode/alamode-setup'
  action :nothing
end

cookbook_file '/etc/udev/rules.d/80-alamode-rules' do
  owner 'root'
  group 'root'
  mode 0644
  source 'alamode-udev-rules'
end
