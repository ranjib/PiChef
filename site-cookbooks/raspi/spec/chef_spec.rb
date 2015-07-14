require 'spec_helper'

describe 'recipe[raspi::chef]' do
  cached(:chef_run) do
    ChefSpec::SoloRunner.new.converge('recipe[raspi::chef]')
  end

  it 'adds goatos packagecloud repo' do
    expect(chef_run).to create_packagecloud_repo('ranjib/goatos').with(
      type: 'deb'
    )
  end

  it 'installs chef package' do
    expect(chef_run).to install_package('chef')
  end
end
