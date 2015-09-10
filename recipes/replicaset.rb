class Chef::Recipe
  include Chef::MachineTagHelper
end

replicaset_members = []

sets = tag_search(node, "mongodb:replicaset=#{node[:rsc_mongodb][:replicaset]}")
puts sets

# sets.each do | set |
#
# 	ip_address = set['server:private_0'].first.value + ':27018'
#
# 	members << {
# 		:host => ip_address
#   	}
# end
#
# replicaset_members.sort! { |a,b| a[:host] <=> b[:host] }
#
# Chef::Log.info "replicaset members " + replicaset_members.inspect
#
# mongodb_replicaset node['mongodb']['replicaset'] do
#   members members
# end
