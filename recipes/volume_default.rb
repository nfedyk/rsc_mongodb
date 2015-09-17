
if node['rsc_mongodb']['use_storage'] == 'true'
  # node.default['rs-storage']['device']['nickname'] = 'mongo_data_volume'
  # node.default['rs-storage']['device']['volume_size'] = '10'
  # node.default['rs-storage']['device']['filesystem'] = 'ext4'
  # node.default['rs-storage']['device']['mount_point'] = '/mnt/mongodb'
#installs right_api_client
include_recipe 'rightscale_volume::default'
include_recipe 'rs-storage::volume'
node.default[:mongodb][:config][:datadir] = "#{node.default['rs-storage']['device']['mount_point']}"

end

# node['rs-storage']['device']['nickname'] = 'mongo_data_volume'
# node['rs-storage']['device']['volume_size'] - the size of the volume to create
# node['rs-storage']['device']['filesystem'] - the filesystem to use on the volume
# node['rs-storage']['device']['mount_point'] - the location to mount the volume



# rightscale_volume "mongo_data_volume" do
#   size 10
#   action :create
# end
#
# # Attaches the volume to the instance
# rightscale_volume "mongo_data_volume" do
#   action :attach
# end
#
# execute "format volume as ext4" do
#   command lazy { "mkfs.ext4 #{node['rightscale_volume']['mongo_data_volume']['device']}" }
#   action :run
# end
#
# execute "mount volume to /mnt/storage" do
#   command lazy { "mkdir -p /mnt/storage; mount #{node['rightscale_volume']['mongo_data_volume']['device']} /mnt/storage" }
#   action :run
# end
