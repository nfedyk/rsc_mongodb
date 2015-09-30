class Chef::Recipe
  include Chef::MachineTagHelper
end

include_recipe 'machine_tag::default'


Chef::Log.info 'Searching for mongodb nodes'
replicaset_hosts = tag_search(node, "mongodb:replicaset=#{node[:rsc_mongodb][:replicaset]}")



replicaset_hosts.each do | server |

   ip_address = server['server:private_ip_0'].first.value + ':27017'
   Chef::Log.info "#{ip_address}"
   rs_config = rs_config.to_s + "{_id: #{host_id}, host: \'#{ip_address}\'},"
   host_id += 1

end


# Chef::Log.info "#{rs_config}"
# ## initiate replica set , replica set name is already in the config
# bash 'initiate the node' do
#   code <<-EOH
#     mongo <<CONFIG
#       rs.add(#{ip_address});
#     CONFIG
#   EOH
#   flags '-xe'
# end
#
# machine_tag "mongodb:replicaset=#{node[:rsc_mongodb][:replicaset]}" do
#    action :create
# end
