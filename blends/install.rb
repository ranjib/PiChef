require 'yaml'
yaml_config = YAML.load_file('blender.yml')
ssh_config = {
  user: yaml_config['user'],
  password: yaml_config['password'],
  stdout: $stdout
}

members([yaml_config['ipaddress']])

config(:ssh, ssh_config)

scp_upload 'validation cert' do
  from yaml_config['validation_cert']
  to '/tmp/validation.pem'
end

ssh_task 'sudo mkdir -p /etc/chef'
ssh_task 'sudo mv /tmp/validation.pem /etc/chef/validation.pem'
ssh_task "echo \"node_name '#{yaml_config['node_name']}'\" > /tmp/client.rb"
ssh_task "echo \"chef_server_url '#{yaml_config['chef_server_url']}'\" >> /tmp/client.rb"
ssh_task 'sudo mv /tmp/client.rb /etc/chef/'
ssh_task 'sudo apt-get update -y'
ssh_task 'sudo apt-get install -y wget'
ssh_task 'download chef' do
  execute "wget -c #{yaml_config['debian_url']} -O /tmp/chef.deb"
end
ssh_task 'sudo dpkg -i /tmp/chef.deb'
ssh_task "sudo chef-client -r #{yaml_config['run_list']}"
ssh_task 'rm /tmp/chef.deb'
