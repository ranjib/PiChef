require 'spec_helper'

describe 'recipe[raspi::builder]' do
  cached(:chef_run) do
    ChefSpec::SoloRunner.new.converge('recipe[raspi::builder]')
  end

  it 'includes omnibus recipe' do
    expect(chef_run).to include_recipe('omnibus')
  end

  it 'installs dependency packages' do
    expect(chef_run).to install_package('deps')
  end

  it 'clones chef omnibus repo' do
    expect(chef_run).to checkout_git('/home/omnibus/omnibus-chef').with(
      repository: 'https://github.com/chef/omnibus-chef.git',
      user: 'omnibus',
      group: 'omnibus',
      revision: '8d0d923a35dffe8f55cb1ca4a9e0fec94b4e4bde'
    )
  end

  it 'drops the raspverry chef ombnibus build script' do
    expect(chef_run).to create_cookbook_file('/home/omnibus/build_chef.sh').with(
      mode: 0754,
      owner: 'omnibus',
      group: 'omnibus'
    )
  end
end
