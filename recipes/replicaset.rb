class Chef::Recipe
  include Chef::MachineTagHelper
end
include_recipe 'machine_tag::default'

replicaset_members = []
Chef::Log.info 'Searching for mongodb nodes'

replicaset_hosts = tag_search(node, "mongodb:replicaset=#{node[:rsc_mongodb][:replicaset]}")


replicaset_hosts.each do | server |
#
   ip_address = server['server:private_ip_0'].first.value + ':27018'
   Chef::Log.info "#{ip_address}"

 	 replicaset_members << {
 		:host => ip_address
   	}
end

node.set['mongodb']['is_replicaset'] = true
node.set['mongodb']['cluster_name'] = node['mongodb']['cluster_name']

#initialize replicaset
