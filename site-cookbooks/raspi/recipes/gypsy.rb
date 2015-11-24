require 'chef/lxc'

package 'ubuntu-fan'

lxc 'go-1.5' do
  template 'download'
  recipe do
    package 'deps' do
      package_name %w(
        git
        mercurial
        wget
        build-essential
        pkg-config
      )
    end
    remote_file '/opt/go.tgz' do
      source 'https://github.com/ranjib/PiChef/releases/download/0.0.1/go.tgz'
    end
    execute 'tar -zxvf /opt/go.tgz -C /opt' do
      creates '/opt/go/bin/go'
    end
    directory '/opt/gospace'
    file '/etc/profile.d/go.sh' do
      content %w(
      #!/bin/bash
      export GOPATH=/opt/gospace
      export GOROOT=/opt/go
      export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
      )
    end
  end
  action [:create, :start]
end
