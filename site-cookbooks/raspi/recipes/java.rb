seed_file = ::File.join(Chef::Config.file_cache_path, 'oracle-jdk.seed')

apt_repository 'webupd8team' do
  uri 'ppa:webupd8team/java'
  distribution node['lsb']['codename']
end

execute 'accept-license' do
  command 'echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections'
  not_if 'dpkg -L oracle-java7-installer'
end

execute 'accept-license' do
  command 'echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections'
  not_if 'dpkg -L oracle-java7-installer'
end

package 'oracle-java7-installer'
