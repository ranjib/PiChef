include_recipe 'omnibus'

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

# omnibus master fails to build on raspberry due to ruby 2.2 download failure
# https://github.com/chef/omnibus-chef/issues/434
git '/home/omnibus/omnibus-chef' do
  repository 'https://github.com/chef/omnibus-chef.git'
  action :checkout
  user 'omnibus'
  group 'omnibus'
  revision '8d0d923a35dffe8f55cb1ca4a9e0fec94b4e4bde'
end

cookbook_file '/home/omnibus/build_chef.sh' do
  mode 0754
  owner 'omnibus'
  group 'omnibus'
end
