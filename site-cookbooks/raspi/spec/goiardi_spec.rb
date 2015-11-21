require 'spec_helper'

describe 'recipe[raspi::goiardi]' do
  cached(:chef_run) do
    ChefSpec::SoloRunner.new.converge('recipe[raspi::goiardi]')
  end

  it 'creates goiardi user' do
    expect(chef_run).to create_user('goiardi')
  end
  %w(
    /opt/goiardi
    /opt/goiardi/data
    /opt/goiardi/conf
    /opt/goiardi/bin
    /opt/goiardi/log
    /opt/goiardi/etc
  ).each do |dir|
    it "creates directory #{dir}"  do
      expect(chef_run).to create_directory(dir).with(
        owner: 'goiardi',
        group: 'goiardi',
        mode: 0755
      )
    end
  end

  it 'downloads the goiardi binary' do
    expect(chef_run).to create_remote_file_if_missing('/opt/goiardi/bin/goiardi').with(
      source: 'https://github.com/ctdk/goiardi/releases/download/v0.9.1/goiardi-0.9.1-linux-armv71',
      owner: 'goiardi',
      group: 'goiardi',
      mode: 0755
    )
  end

  it 'creates goiardi config file' do
    expect(chef_run).to create_template('/opt/goiardi/etc/goiardi.conf').with(
      owner: 'goiardi',
      group: 'goiardi',
      mode: 0644,
      variables: {hostname: chef_run.node.ipaddress}
    )
  end

  it 'creates goiardi systemd service' do
    expect(chef_run).to create_systemd_service('goiardi').with(
      description: 'Goiardi',
      user: 'goiardi',
      permissions_start_only: true,
      exec_start: '/opt/goiardi/bin/goiardi -c /opt/goiardi/etc/goiardi.conf',
      restart: 'always',
      restart_sec: '10s',
      wanted_by: 'multi-user.target'
    )
  end
end
