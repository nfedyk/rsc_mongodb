node.default['rs-storage']['device']['mount_point'] = "#{node['rsc_mongodb']['volume_mount_point']}"
node.default['rs-storage']['backup']['lineage'] = "#{node['rsc_mongodb']['backup_lineage_name']}"

Chef::Log.info "#{node['rsc_mongodb']['backup_lineage_name']}"

include_recipe 'rs-storage::backup'
