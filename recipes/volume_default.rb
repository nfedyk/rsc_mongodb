
include_recipe 'rightscale_volume::default'

rightscale_volume "db_data_volume" do
  size 10
  action :create
end
