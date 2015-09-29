class Chef::Recipe
  include Chef::MachineTagHelper
end

include_recipe 'machine_tag::default'

Chef::Log.info 'Searching a mongodb node'

mongo_node = tag_search(node, "mongodb:replicaset=#{node[:rsc_mongodb][:replicaset]}")


   ip_address = mongo_node['server:private_ip_0'].first.value + ':27017'
   Chef::Log.info "#{ip_address}"



rs_config = rs_config.to_s + "     ]
}"

Chef::Log.info "#{rs_config}"
## initiate replica set , replica set name is already in the config
bash 'initiate the node' do
  code <<-EOH
    mongo <<CONFIG
      rs.add(#{ip_address});
    CONFIG
  EOH
  flags '-xe'
end
