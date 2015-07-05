# -*- ft:ruby -*-
source 'https://api.berkshelf.com'

cookbook 'sensu', github: 'sensu/sensu-chef'
cookbook 'packagecloud'

Dir["site-cookbooks/**"].sort.each do |cookbook_path|
  cookbook File.basename(cookbook_path), path: cookbook_path
end
