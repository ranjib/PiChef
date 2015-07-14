require 'chefspec'

RSpec.configure do |c|
  c.cookbook_path = %w(vendor site-cookbooks).map{|d| File.expand_path("../../#{d}", __FILE__)}
   c.version = '14.04'
   c.platform = 'ubuntu'
end
