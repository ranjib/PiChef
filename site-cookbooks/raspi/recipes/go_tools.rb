git '/home/omnibus/etcd' do
  repository 'https://github.com/coreos/etcd.git'
  action :sync
  user 'omnibus'
  group 'omnibus'
end

git '/home/omnibus/vault' do
  repository 'https://github.com/hashicorp/vault.git'
  action :sync
  user 'omnibus'
  group 'omnibus'
end
