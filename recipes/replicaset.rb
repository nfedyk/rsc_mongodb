class Chef::Recipe
  include Chef::MachineTagHelper
end

include_recipe 'machine_tag::default'

replicaset_members = []
Chef::Log.info 'Searching for mongodb nodes'

replicaset_hosts = tag_search(node, "mongodb:replicaset=#{node[:rsc_mongodb][:replicaset]}")

host_id=0
rs_config = "config = {
    _id : #{node[:rsc_mongodb][:replicaset]},
     members : ["


replicaset_hosts.each do | server |

   ip_address = server['server:private_ip_0'].first.value + ':27017'
   Chef::Log.info "#{ip_address}"
   rs_config = rs_config.to_s + "{_id: #{host_id}, host: #{ip_address}},"
   host_id += 1
  #  bash 'add node to replicaset' do
  #    code <<-EOH
  #       mongo --quiet <<EOF
  #         rs.add("#{ip_address}");
  #       EOF
  #     EOH
  #   end
end
rs_config = rs_config.to_s + "     ]
}"

Chef::Log.info "#{rs_config}"
## initiate replica set , replica set name is already in the config
bash 'initiate the node' do
  code <<-EOH
    mongo --quiet <<EOF
      rs.initiate("#{rs_config}");
    EOF
  EOH
  flags '-x'
end
