packagecloud_repo 'ranjib/goatos' do
  type 'deb'
end

package 'chef' do
  version node['raspi']['chef_version']
end
