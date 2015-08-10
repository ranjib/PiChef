require 'spec_helper'

describe 'recipe[raspi::kiosk]' do
  cached(:chef_run) do
    ChefSpec::SoloRunner.new.converge('recipe[raspi::kiosk]')
  end
  it 'install all gui related packages' do
    expect(chef_run).to install_package('gui').with(
      package_name: %w(
        chromium-browser
        dphys-swapfile
        libraspberrypi-bin
        libraspberrypi-dev
        lxde
        linux-firmware
        libraspberrypi-bin-nonfree
        xserver-xorg-video-fbturbo
      )
    )
  end

  it 'configures X' do
    expect(chef_run).to create_cookbook_file('/etc/X11/xorg.conf').with(
      owner: 'root',
      group: 'root',
      mode: 0644
    )
  end

  it 'creatse lxde autostart config' do
    expect(chef_run).to create_template('/etc/xdg/lxsession/LXDE/autostart').with(
      owner: 'root',
      group: 'root',
      mode: 0644,
      source: 'lxde_autostart.erb'
    )
  end
end
