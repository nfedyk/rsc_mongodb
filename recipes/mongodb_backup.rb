node.default['rs-storage']['device']['mount_point'] = "#{node['rsc_mongodb']['volume_mount_point']}"
include_recipe 'rs-storage::backup'
