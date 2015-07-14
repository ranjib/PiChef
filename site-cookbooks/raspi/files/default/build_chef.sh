#!/bin/bash


# assume pi-ruby is present (ruby 2.2.2 installed /opt/rubies/2.2.2)
set -e
set -o pipefail


VERSION=`lsb_release  -a 2> /dev/null | grep Codename: | awk '{print $2}'`
source /home/omnibus/load-omnibus-toolchain.sh
cd /home/omnibus/omnibus-chef
rm -rf pkg
rm -rf /home/omnibus/chef-transform
mkdir -p  /home/omnibus/chef-transform
bundle install --path .bundle --without development
bundle exec omnibus build chef
mv pkg/*.deb /home/omnibus/chef-transform/chefx.deb
cd /home/omnibus/chef-transform
dpkg-deb -x chefx.deb chef
dpkg-deb -e chefx.deb chef/DEBIAN
sed -ir "s/Architecture: armv7l/Architecture: armhf/" chef/DEBIAN/control
dpkg-deb -b chef chef.deb
mv chef.deb /home/omnibus/chef-$(VERSION).deb
cd /tmp
rm -rf /home/omnibus/chef-transform
