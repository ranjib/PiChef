#!/bin/bash
set -e
cd /opt/pichef/builder/ruby
wget -c http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.2.tar.gz
tar -zxvf ruby-2.2.2.tar.gz
cd ruby-2.2.2
bash ./configure --enable-shared --disable-install-doc --disable-install-rdoc --disable-install-capi --prefix=/opt/rubies/2.2.2
make
make install
/opt/chef/bin/fpm -s dir -t deb -n ruby -v 2.2.2 /opt/rubies/2.2.2
rm -rf /opt/rubies/2.2.2
