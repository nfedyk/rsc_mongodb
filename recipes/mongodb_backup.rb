node.override['rs-storage']['device']['mount_point'] = "#{node['rsc_mongodb']['volume_mount_point']}"
node.override['rs-storage']['backup']['lineage'] = 'blahblah'
#node.override['rs-storage']['backup']['lineage'] = "#{node['rsc_mongodb']['backup_lineage_name']}"

Chef::Log.info "Backup Lineage: #{node['rsc_mongodb']['backup_lineage_name']}"

include_recipe 'rs-storage::backup'
