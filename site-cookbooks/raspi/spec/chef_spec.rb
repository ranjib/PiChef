require 'spec_helper'

describe 'recipe[raspi::chef]' do
  cached(:chef_run) do
    ChefSpec::SoloRunner.new.converge('recipe[raspi::chef]')
  end

  it 'create chef systemd service unit' do
    expect(chef_run).to create_systemd_service('chef')
  end

  it 'create chef systemd timer unit' do
    expect(chef_run).to create_systemd_timer('chef')
  end
end
