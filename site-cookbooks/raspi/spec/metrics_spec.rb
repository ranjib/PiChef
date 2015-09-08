require 'spec_helper'

describe 'recipe[raspi::metrics]' do
  let(:grafana_deb_path) do
    File.join(Chef::Config.file_cache_path, 'grafana_2.2.0-pre1_armhf.deb')
  end

  cached(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
    end.converge('recipe[raspi::metrics]')
  end

  it 'install dependency package' do
    expect(chef_run).to install_package('metrics-deps').with(
      package_name: %w(fontconfig-config libfontconfig1)
    )
  end

  it 'creats influxdb user' do
    expect(chef_run).to create_user('influxdb').with(
      system: true,
      home: '/opt/influxdb',
      manage_home: true
    )
  end

  it 'downloads influxdb bindary file' do
    expect(chef_run).to create_remote_file_if_missing('/opt/influxdb/influxd')
  end

  it 'creates configuration file for influxd' do
    expect(chef_run).to create_cookbook_file('/opt/influxdb/influxdb.conf').with(
      mode: 0644,
      owner: 'influxdb',
      group: 'influxdb'
    )
  end

  it 'creates default environment config file for influxdb' do
    expect(chef_run).to create_cookbook_file('/etc/default/influxdb').with(
      mode: 0644,
      source: 'influxdb.sh'
    )
  end

  it 'creates systemd service unit' do
    expect(chef_run).to create_systemd_service('influxdb').with(
      description: 'InfluxDB is an open-source, distributed, time series database',
      after: 'network.target',
      user: 'influxdb',
      group: 'influxdb',
      limit_nofile: '65536',
      environment_file: '-/etc/default/influxdb',
      exec_start: '/opt/influxdb/influxd -config /opt/influxdb/influxdb.conf $INFLUXD_OPTS',
      restart: 'on-failure',
      wanted_by: 'multi-user.target'
    )
  end

  it 'downloads grafana debian package' do
    expect(chef_run).to create_remote_file_if_missing(grafana_deb_path)
  end

  it 'install grafana debian package' do
    expect(chef_run).to install_dpkg_package('grafana').with(
      source: grafana_deb_path
    )
  end

  it 'start grafana service' do
    expect(chef_run).to start_service('grafana-server')
  end
end
