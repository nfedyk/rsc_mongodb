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

 	 mongodb_members << {
 		:host => ip_address
   	}
end
#
# replicaset_members.sort! { |a,b| a[:host] <=> b[:host] }
#
# Chef::Log.info "replicaset members " + replicaset_members.inspect
#
# mongodb_replicaset node['mongodb']['replicaset'] do
#   members members
# end
