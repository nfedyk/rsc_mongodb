class Chef::Recipe
  include Chef::MachineTagHelper
end

include_recipe 'machine_tag::default'

#store host info for each member

Chef::Log.info 'Searching for mongodb nodes'
replicaset_hosts = tag_search(node, "mongodb:replicaset=#{node[:rsc_mongodb][:replicaset]}")

#debug
Chef::Log.info "ReplicaSet #{replicaset_hosts}"

#id for each host as it's added.
host_id=0
#start of generate config file to pass to rs.initiate()
rs_config = "config = {
    _id : \'#{node[:rsc_mongodb][:replicaset]}\',
     members : ["


replicaset_hosts.each do | server |

   ip_address = server['server:private_ip_0'].first.value + ':27017'
   Chef::Log.info "#{ip_address}"
   rs_config = rs_config.to_s + "{_id: #{host_id}, host: \'#{ip_address}\'},"
   host_id += 1

end
rs_config = rs_config.to_s + "     ]
}"
#end of generate config file

Chef::Log.info "#{rs_config}"
## initiate replica set , replica set name is already in the config
bash 'initiate the node' do
  code <<-EOH
      mongo <<EOF
        rs.initiate("#{rs_config}".to_s);
        EOF
  EOH
  flags '-xe'
end
