package 'deps' do
  package_name %w(
    autoconf
    automake
    bison
    build-essential
    libncurses5-dev
    libreadline6
    libreadline6-dev
    libssl-dev
    libtool
    libyaml-dev
    zlib1g
    zlib1g-dev
    openssl
    libreadline6-dev
    git-core
    zlib1g
    libssl-dev
    libsqlite3-dev
    sqlite3
    libxml2-dev
    libxslt-dev
  )
end

%w(ruby chef).each do |d|
  directory "/opt/pichef/builder/#{d}" do
    recursive true
  end
end
ruby_debian_path = ::File.join(Chef::Config.file_cache_path, 'pi-ruby_2.2.2_armhf.deb')
remote_file ruby_debian_path do
  source 'https://github.com/ranjib/PiChef/releases/download/0.0.1/pi-ruby_2.2.2_armhf.deb'
  action :create_if_missing
end

dpkg_package 'pi-ruby' do
  source ruby_debian_path
end

%w(bundler fpm).each do |g|
  gem_package g do
    gem_binary '/opt/rubies/2.2.2/bin/gem'
    options "--no-ri --no-rdoc"
  end
end

cookbook_file '/opt/pichef/builder/chef/build_chef.sh' do
  mode 0754
end

cookbook_file '/opt/pichef/builder/ruby/build_ruby.sh' do
  mode 0754
end
