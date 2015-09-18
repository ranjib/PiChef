default['raspi']['timezone'] = 'America/Los_Angeles'
default['raspi']['boot_options'] = nil # defaults to Raspi.boot_options
default['raspi']['chef_version'] = nil # goatos/raspi
default['raspi']['kiosk'].tap do |k|
  k['statup_app'] = 'chromium-browser --noerrdialogs --kiosk https://www.google.com --incognito'
end
default['raspi']['metrics'].tap do |m|
  m['influxdb_url'] = 'https://github.com/ranjib/PiChef/releases/download/0.0.2/influxd'
  m['grafana_deb_url'] = 'https://github.com/ranjib/PiChef/releases/download/0.0.2/grafana_2.2.0-pre1_armhf.deb'
end

default['raspi']['serf_download_url'] = 'https://github.com/ranjib/PiChef/releases/download/0.0.2/serf'
default['raspi']['serf_config'] = {}

default['raspi']['etcd_download_url'] = 'https://github.com/ranjib/PiChef/releases/download/0.0.2/serf'
