
node.default['rs-storage']['device']['nickname'] = "#{node['rsc_mongodb']['volume_nickname']}"
node.default['rs-storage']['device']['volume_size'] = "#{node['rsc_mongodb']['volume_size']}"
node.default['rs-storage']['device']['filesystem'] = "#{node['rsc_mongodb']['volume_filesystem']}"
node.default['rs-storage']['device']['mount_point'] = "#{node['rsc_mongodb']['volume_mount_point']}"

#installs right_api_client
include_recipe 'rightscale_volume::default'

#if "#{node.default['rs-storage']['device']['mount_point']}" exists mv

include_recipe 'rs-storage::volume'

#when using volumes we set the datadir to the mount point.
node.default[:mongodb][:config][:dbpath] = "#{node.default['rs-storage']['device']['mount_point']}"

node.default[:rs-storage][:restore][:lineage] = "#{node['rsc_mongodb']['restore_lineage_name']}"
