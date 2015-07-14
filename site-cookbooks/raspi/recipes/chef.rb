packagecloud_repo 'goatos/raspi' do
  type 'deb'
end

package 'chef' do
  version node['raspi']['chef_version']
end
