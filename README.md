## PiChef
Chef cookbooks, knife plugins and other utility scripts for Raspberry Pi

### Introduction
PiChef intends to ease maintaining your Raspberry Pi configuration. Currently
it provides following thing:
- Chef debian installer for Raspbian
- goiardi recipe to run a chef server inside raspberry pi
- blender based scripts automate installtion, build and other orchestrated workflows.

### Setup
This guide assumes you are running Raspbian and your Pi is accessible via
remote ssh. `Workstation` is assumed to be a separate machine (can be your laptop)
from where Pi will be managed.

On your workstation:

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
