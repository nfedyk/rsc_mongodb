
if node['rsc_mongodb']['use_storage'] == 'true'
node.default['rs-storage']['device']['nickname'] = "#{node['rsc_mongodb']['volume_nickname']}"
node.default['rs-storage']['device']['volume_size'] = "#{node['rsc_mongodb']['volume_size']}"
node.default['rs-storage']['device']['filesystem'] = "#{node['rsc_mongodb']['volume_filesystem']}"
node.default['rs-storage']['device']['mount_point'] = "#{node['rsc_mongodb']['volume_mount_point']}"



#installs right_api_client
include_recipe 'rightscale_volume::default'
include_recipe 'rs-storage::volume'

#when using volumes we set the datadir to the mount point.
node.default[:mongodb][:config][:datadir] = "#{node.default['rs-storage']['device']['mount_point']}"

end
