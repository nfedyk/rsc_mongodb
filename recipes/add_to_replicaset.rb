marker "recipe_start"

marker "recipe_start_rightscale" do
  template "rightscale_audit_entry.erb"
end

class Chef::Recipe
  include Chef::MachineTagHelper
end

include_recipe 'machine_tag::default'


Chef::Log.info 'Searching for mongodb nodes'
replicaset_hosts = tag_search(node, "mongodb:replicaset=#{node[:rsc_mongodb][:replicaset]}")

ip_address = replicaset_hosts[1]['server:private_ip_0'].first.value
Chef::Log.info "Host ip: #{ip_address}"

#   $ip_address = server['server:private_ip_0'].first.value + ':27017'




#find primary
#{primary_mongo_node} = mongo --quiet --eval "db.isMaster()['primary']"

## initiate replica set , replica set name is already in the config

file '/tmp/mongoconfig.js' do
  content "rs.add("#{node[:cloud][:private_ips][0]}");"
end

execute 'configure_mongo' do
  command '/usr/bin/mongo /tmp/mongoconfig.js'
end

Chef::Log.info "Node's Current IP: #{node['cloud']['private_ips'][0]}"

bash 'initiate the node' do
  code <<-EOH
    mongo --host #{node[:rsc_mongodb][:replicaset]}/#{ip_address}<<CONFIG
      rs.add(#{node['cloud']['private_ips'][0]});
    CONFIG
  EOH
  flags '-xe'
end

machine_tag "mongodb:replicaset=#{node[:rsc_mongodb][:replicaset]}" do
   action :create
end

#Backup the restored node only after it has joined the replicaset

if node['rsc_mongodb']['restore_from_backup'] == 'true'

Chef::Log.info "Volumes are being used. Adding backup script and cronjob"

    #create the backup script.
    template '/usr/bin/mongodb_backup.sh' do
      source 'mongodb_backup.erb'
      owner 'root'
      group 'root'
      mode '0755'
    end

    cron 'mongodb-backup' do
      minute  '0'
      hour    '*/1'
      command '/usr/bin/mongodb_backup.sh'
      user    'root'
    end
#mongo --quiet --eval "d=db.isMaster(); print( d['ismaster'] );"
#if true , exit. false run the backups.
end

#connects to primary everytime.
#mongo --host my_repl_set_name/my_mongo_server1
