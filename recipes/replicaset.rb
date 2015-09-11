class Chef::Recipe
  include Chef::MachineTagHelper
end

## initiate replica set , replica set name is already in the config
bash 'initiate the node' do
  code <<-EOH
    mongo --quiet <<EOF
    rs.initiate();
    EOF
  EOH
end

include_recipe 'machine_tag::default'

replicaset_members = []
Chef::Log.info 'Searching for mongodb nodes'

replicaset_hosts = tag_search(node, "mongodb:replicaset=#{node[:rsc_mongodb][:replicaset]}")


replicaset_hosts.each do | server |

   ip_address = server['server:private_ip_0'].first.value + ':27017'
   Chef::Log.info "#{ip_address}"
   bash 'add node to replicaset' do
     code <<-EOH
        mongo --quiet <<EOF
          rs.add(#{ip_address});
        EOF
      EOH

 # 	 replicaset_members << {
 # 		:host => ip_address
  #  	}
end



# #initialize replicaset
# ## initiate replica set
# bash 'configure the replicaset' do
#   code <<-EOH
#     mongo --quiet <<EOF
#     rs.initiate({
#       _id: '#{node[:rsc_mongodb][:replicaset]}',
#       members: [
#         {_id: 0, host: '10.180.214.2:27017'},
#         {_id: 1, host: '10.237.182.130:27017'},
#         {_id: 2, host: '10.65.181.158:27017'}
#         ]
#       });
#     EOF
#   EOH
# end
