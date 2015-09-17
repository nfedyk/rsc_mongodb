
if node['rsc_mongodb']['use_storage'] == 'true'
node.default['rs-storage']['device']['nickname'] = "#{node['rsc_mongodb']['volumn_nickname']}"
node.default['rs-storage']['device']['volume_size'] = "#{node['rsc_mongodb']['volume_size']}"
node.default['rs-storage']['device']['filesystem'] = "#{node['rsc_mongodb']['volume_filesystem']}"
node.default['rs-storage']['device']['mount_point'] = "#{node['rsc_mongodb']['volume_mount_point']}"


#installs right_api_client
include_recipe 'rightscale_volume::default'
include_recipe 'rs-storage::volume'
node.default[:mongodb][:config][:datadir] = "#{node.default['rs-storage']['device']['mount_point']}"

#if not the master , run backups ,  is.Master() logic , here on in cron job script

end
