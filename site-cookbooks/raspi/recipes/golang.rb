tarball = 'go1.4.2.linux-arm~multiarch-armv7-1.tar.gz'
tarball_path = ::File.join(Chef::Config[:file_cache_path], tarball)

remote_file tarball_path do
  source "http://dave.cheney.net/paste/#{tarball}"
  action :create_if_missing
  notifies :run, 'execute[decompress_tarball]'
end

execute 'decompress_tarball' do
  command "tar -zxf #{tarball_path} -C /opt"
  action :nothing
end
