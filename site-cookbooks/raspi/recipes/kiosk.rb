package 'gui' do
  package_name %w(
    chromium-browser
    dphys-swapfile
    libraspberrypi-bin
    libraspberrypi-dev
    lxde
    linux-firmware
    libraspberrypi-bin-nonfree
    xserver-xorg-video-fbturbo
  )
end

cookbook_file '/etc/X11/xorg.conf' do
  owner 'root'
  group 'root'
  mode 0644
end

template '/etc/xdg/lxsession/LXDE/autostart' do
  owner 'root'
  group 'root'
  mode 0644
  source 'lxde_autostart.erb'
  variables(
    statup_app: node.raspi.kiosk.statup_app
  )
end
