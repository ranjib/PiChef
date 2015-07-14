# -*- ft:ruby -*-
source 'https://api.berkshelf.com'

cookbook 'apparmor'
cookbook 'application'
cookbook 'apt'
cookbook 'chef-client'
cookbook 'container'
cookbook 'nagios'
cookbook 'omnibus'
cookbook 'openssh'
cookbook 'ossec'
cookbook 'packagecloud'
cookbook 'sudo'
cookbook 'systemd'

Dir['site-cookbooks/**'].sort.each do |cookbook_path|
  cookbook File.basename(cookbook_path), path: cookbook_path
end
