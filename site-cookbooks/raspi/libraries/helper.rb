module Raspi
  extend self
  def default_boot_options
    %w(hdmi_force_hotplug=1 dtparam=i2c1=on dtparam=i2c_arm=on)
  end
end
