require 'chef/knife'

module PiChef
  class GoiardiBackup < Chef::Knife

    deps do
      require 'blender'
    end

    banner 'knife goiardi backup [-f FILE][-h HOST]'

    option :backup_file,
      short: '-f FILE',
      long: '--file FILE',
      description: 'Backup file name (will be generated)',
      default: 'goiardi-backup.tgz'

    option :host,
      short: '-h HOST',
      long: '--host HOST',
      description: 'Goiardi host',
      default: nil

    def run
      goiardi_host = config[:host]
      goiardi_host ||= URI(Chef::Config.chef_server_url).host
      backup_file = config[:backup_file]
      Blender.blend 'goiardi backup' do |sched|
        sched.members([goiardi_host])
        sched.config(:ssh, user: 'ubuntu', password: 'ubuntu', stdout: $stdout, stderr: $stderr)
        sched.ssh_task 'sudo tar -czvf goiardi.tgz /opt/goiardi/conf /opt/goiardi/data'
        sched.scp_download 'goiardi backup' do
          from 'goiardi.tgz'
          to backup_file
        end
        sched.ssh_task 'sudo rm goiardi.tgz'
      end
    end
  end
end
