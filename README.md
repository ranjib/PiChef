PiChef
=========
[![Built on Travis](https://secure.travis-ci.org/ranjib/pichef.png?branch=master)](http://travis-ci.org/ranjib/pichef)

Chef on Raspberry Pi.

### Introduction

PiChef brings the joy of configuration management system [Chef](https://www.chef.io/chef/)
on [Raspberry Pi](https://www.raspberrypi.org/).
PiChef is built with following goals
  - Ease building and maintaining raspberry pi related projects (like weather stations, CNC machines, home automation systems) by providing chef installers for Raspberry Pi, generic server administration cookbooks (sudo, ssh) etc.
  - Setting up a continuous integration chain with upstream Chef project and [essential chef cookbooks](https://github.com/ranjib/pichef#cookbooks) using [GoatOS](https://github.com/goatos) so that essential community cookbooks will always be tested with upstream chef changes on ubuntu.
  - As a learning platform for system automation (run a small data center backed by chef).

Currently PiChef provides following:
- Chef omnibus packages for Raspberry Pi, available from [GoatOS RasPi](https://packagecloud.io/goatos/raspi) packagecloud repository.
- Cookbook to run [Goiardi](https://github.com/ctdk/goiardi), an opensource chef server written in [go](https://golang.org/).
- Roles to configure omnibus build servers


### Getting started

- If you are new to Chef or configuration management system read a little about Chef. Following
are great resources.
  - [learn chef](https://learn.chef.io/) website
- Settin up your workstation
  - This guide assumes all your Raspberry Pi are accessible via
ssh. `Workstation` is assumed to be a separate machine (can be your laptop)
from where Pi will be managed.
    - Install ruby and bundler.
    - Clone this repository
    - Install all gem dependencies
      ```sh
      bundle install --path .bundle
      ```
    - Install chef on a RaspberryPi
      ```sh
      bundle exec knife blend blends/install.rb -h <IPADDRESS> --prompt
      ```

- Basic topology
  - chef server
  - build agents
  - the weather station
  - mechanical radiators
    - LED Segments
    - Steppers

### Setting up pi
This section is based on Ubuntu/ARM wiki [page](https://wiki.ubuntu.com/ARM/RaspberryPi).
Assuming you ubuntu is the development box
  - download trusty image from [here](http://www.finnie.org/software/raspberrypi/2015-04-06-ubuntu-trusty.zip) and unzip it.
  - Write the image to an sd card
  ```sh
    sudo bmaptool copy --bmap ubuntu-trusty.bmap ubuntu-trusty.img /dev/mmcblk0
  ```
  - modify the diskpartition in sd card to expand entire storage capacity.
  ```sh
  sudo fdisk /dev/mmcblk0
  ```
  Delete the second partition (d, 2), then re-create it using the defaults (n, p, 2, enter, enter), then write and exit (w). Reboot the system.
  ```sh
  sudo resize2fs /dev/mmcblk0p2
  ```
  - Install ssh
  ```sh
  sudo apt-get install openssh-server
  ```
  - download and install chef
  ```sh
  wget -c https://packagecloud.io/goatos/raspi/packages/ubuntu/trusty/chef_12.5.0_armhf.deb/download -O chef.deb
  sudo dpkg -i chef.deb
  ```

### Cookbooks

Currently following cookbooks are tested under GoatOS with PiChef

- openssh
- sudo
- apparmor
- omnibus

## Contributing/Development

The general development process is:

1. Fork this repo and clone it to your workstation
2. Create a feature branch for your change
3. Write code and tests
4. Push your feature branch to github and open a pull request against
   master

Once your repository is set up, you can start working on the code. We do use
TDD with RSpec, so you'll need to get a development environment running.
Follow the above procedure ("Installing from Git") to get your local
copy of the source running.


### LICENSE

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
