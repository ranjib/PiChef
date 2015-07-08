#package_name = Dir['./*.deb'].grep(/pi-chef/).first
#
package_name = "pi-chef_12.5.0.current.0_armhf.deb"

ssh_task 'sudo apt-get remove chef -y --purge' do
  ignore_failure true
end

ssh_task 'sudo apt-get remove pi-chef -y --purge' do
  ignore_failure true
end

ssh_task 'sudo rm -rf /opt/chef'
ssh_task "sudo rm -rf /tmp/#{package_name}"

scp_upload 'upload chef build' do
  from package_name
  to "/tmp/#{package_name}"
end

ssh_task "sudo dpkg -i /tmp/#{package_name}"
