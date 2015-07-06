#!/bin/bash


# assume pi-ruby is present (ruby 2.2.2 installed /opt/rubies/2.2.2)
set -e

export PATH=/opt/rubies/2.2.2/bin:$PATH

# build ruby 2.2.2 with /opt/chef as target installation directory
cd /opt/pichef/builder/chef
wget -c http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.2.tar.gz
tar -zxvf ruby-2.2.2.tar.gz
cd ruby-2.2.2
bash ./configure --enable-shared --disable-install-doc --disable-install-rdoc --disable-install-capi --prefix=/opt/chef
make
make install
gem install bundler --no-ri --no-rdoc
cd ..
rm -rf ruby-2.2.2

#build chef from master
git clone https://github.com/chef/chef.git
cd chef
CHEF_VERSION=`cat VERSION`
bundle install --path .bundle
bundle exec rake package_components
bundle exec rake package
gem install chef-config/pkg/chef-${CHEF_VERSION}.gem
gem install pkg/chef-${CHEF_VERSION}.gem
fpm -s dir -t deb -n pi-chef -v ${CHEF_VERSION} /opt/chef
