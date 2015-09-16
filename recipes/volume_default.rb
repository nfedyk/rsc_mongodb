
include_recipe 'rightscale_volume::default'

rightscale_volume "mongo_data_volume" do
  size 10
  action :create
end

# Attaches the volume to the instance
rightscale_volume "mongo_data_volume" do
  action :attach
end

execute "format volume as ext4" do
  command lazy { "mkfs.ext4 #{node['rightscale_volume']['mongo_data_volume']['device']}" }
  action :run
end

execute "mount volume to /mnt/storage" do
  command lazy { "mkdir -p /mnt/storage; mount #{node['rightscale_volume']['mongo_data_volume']['device']} /mnt/storage" }
  action :run
end
