ssh_task 'sudo apt-get update -y'
ssh_task 'sudo apt-get install -y wget'

ssh_task 'download chef' do
  execute 'wget -c https://github.com/ranjib/PiChef/releases/download/0.0.1/chef-12.2.1.deb'
end

ssh_task 'sudo dpkg -i chef-12.2.1.deb'
ssh_task 'rm chef-12.2.1.deb'
