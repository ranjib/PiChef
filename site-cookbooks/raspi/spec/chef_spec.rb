require 'spec_helper'

describe 'recipe[raspi::chef]' do
  cached(:chef_run) do
    ChefSpec::SoloRunner.new.converge('recipe[raspi::chef]')
  end

  it 'installs chef package' do
    expect(chef_run).to create_systemd_timer('chef')
  end
end
