require 'spec_helper'

describe 'recipe[raspi::metrics]' do
  cached(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
    end.converge('recipe[raspi::metrics]')
  end

  it 'downloads influxdb bindary file' do
    expect(chef_run).to create_remote_file_if_missing('/opt/influxdb/influxd')
  end
end
