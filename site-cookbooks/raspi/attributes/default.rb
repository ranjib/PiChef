default['raspi']['timezone'] = 'America/Los_Angeles'
default['raspi']['boot_options'] = nil # defaults to Raspi.boot_options
default['raspi']['chef_version'] = nil # goatos/raspi
default['raspi']['kiosk'].tap do |k|
  k['statup_app'] = 'chromium-browser --noerrdialogs --kiosk https://www.google.com --incognito'
end
