#!/bin/bash
set -e

apt-get remove chef --purge -y
rm -rf /opt/chef
mkdir /opt/chef
chown omnibus:omnibus /opt/chef
sudo -u omnibus /home/omnibus/build_chef.sh
rm -rf /opt/chef
chef-client
