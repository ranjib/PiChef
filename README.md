## PiChef
Chef cookbooks, knife plugins and other utility scripts for Raspberry Pi

### Introduction

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

## Usage

- Build a chef installer (debian package) for Raspberry Pi

```sh
  bundle exec knife blend blends/build.rb -h IPADDRESS -u pi --prompt
```
-
