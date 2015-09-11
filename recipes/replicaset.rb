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
          rs.add("#{ip_address}");
        EOF
      EOH
    end
end
