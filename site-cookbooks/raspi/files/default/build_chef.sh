#!/bin/bash


# assume pi-ruby is present (ruby 2.2.2 installed /opt/rubies/2.2.2)
set -e


# build ruby 2.2.2 with /opt/chef as target installation directory
cd /opt/pichef/builder/chef
wget -c http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.2.tar.gz
tar -zxvf ruby-2.2.2.tar.gz
cd ruby-2.2.2
bash ./configure --enable-shared --disable-install-doc --disable-install-rdoc --disable-install-capi --prefix=/opt/chef
make
make install
/opt/chef/bin/gem install bundler --no-ri --no-rdoc
cd ..
rm -rf ruby-2.2.2*

export PATH=/opt/chef/bin:$PATH

#build chef from master
git clone https://github.com/chef/chef.git
cd chef
CHEF_VERSION=`cat VERSION`
bundle install --path .bundle
bundle exec rake package_components
gem install chef-config/pkg/chef-config-${CHEF_VERSION}.gem
bundle exec rake package
gem install pkg/chef-${CHEF_VERSION}.gem
/opt/rubies/2.2.2/bin/fpm -s dir -t deb -n pi-chef -v ${CHEF_VERSION} /opt/chef
rm -rf /opt/chef
