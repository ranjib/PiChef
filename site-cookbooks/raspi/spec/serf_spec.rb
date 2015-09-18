require 'spec_helper'

describe 'recipe[raspi::serf]' do
  cached(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
    end.converge('recipe[raspi::serf]')
  end

  it 'install serf binart' do
    expect(chef_run).to  create_remote_file('/usr/bin/serf')
  end

  it 'creates serf config directory' do
    expect(chef_run).to create_directory('/etc/serf')
  end

  it 'ceeates serf config file' do
    expect(chef_run).to create_file('/etc/serf/agent.json')
  end

  it 'creates syetmd service unit for serf' do
    expect(chef_run).to create_systemd_service('serf')
  end
end
