require 'mixlib/shellout'

module PiChef
  module Debian
    extend self

    def install_home
      '/opt/pi-chef'
    end

    def before_install
      [ bash, "rm -rf #{install_home}" ].join("\n")
    end

    def after_install
      [ bash, "chmod -R +r #{install_home}" ].join("\n")
    end

    def bash
      '#!/bin/bash'
    end

    def solo_config
      [
        "file_cache_path '/var/cache/chef/cookbooks",
        "cookbook_path '/opt/#{install_home}/cookbooks'"
      ].join("\n")
    end

    def shell_out!(command)
      cmd = Mixlib::ShellOut.new(command)
      cmd.live_stream = $stdout
      yield cmd if block_given?
      cmd.run_command
      fail "Failed to run: '#{command}'\nSTDOUT: #{cmd.stdout}\nSTDERR: #{cmd.stderr}" unless cmd.exitstatus.zero?
    end
  end
end
