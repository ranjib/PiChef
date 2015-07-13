require 'foodcritic'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'fileutils'
require 'berkshelf'
require 'berkshelf/berksfile'
require_relative 'lib/pi_chef/version'
require_relative 'lib/pi_chef/debian'
require 'tempfile'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = %w(site-cookbooks/**/*_spec.rb)
end

package_name = 'pi-chef'

desc 'rubocop compliancy checks'
RuboCop::RakeTask.new(:rubocop) do |t|
  t.patterns = %w(
    Rakefile
    Berksfile
    Gemfile
    site-cookbooks/**/*.rb
    blends/*.rb
    roles/*.rb
  )
  t.fail_on_error = true
end

desc 'Vendorize all cookbooks using berks'
task 'vendor' do
end

desc 'Create debian package of the cookbooks'
task package: :vendor do
  package = "#{package_name}_#{PiChef::VERSION}_all.deb"
  FileUtils.rm_rf(package_name) if Dir.exist?(package_name)
  File.unlink(package) if File.exist?(package)
  berksfile = Berkshelf::Berksfile.from_file('Berksfile')
  berksfile.vendor(File.join(package_name, 'cookbooks'))
  FileUtils.mkdir_p(File.join(package_name, 'etc'))
  File.open(File.join(package_name, 'etc', 'solo.rb'), 'w') do |f|
    f.write(PiChef::Debian.solo_config)
  end
  after = Tempfile.new('pi-chef')
  after.write(PiChef::Debian.after_install)
  after.close
  before = Tempfile.new('pi-chef')
  before.write(PiChef::Debian.before_install)
  before.close
  command = 'bundle exec fpm -s dir -t deb --prefix=/opt -a all'
  command << " --before-install #{before.path}"
  command << " --after-install #{after.path}"
  command << " -v #{PiChef::VERSION} -n #{package_name} #{package_name}"
  begin
    PiChef::Debian.shell_out!(command)
  ensure
    after.unlink
    before.unlink
    FileUtils.rm_rf(package_name) if Dir.exist?(package_name)
  end
end
