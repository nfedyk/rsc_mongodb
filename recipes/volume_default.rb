#
# Cookbook Name:: rsc_mongodb
# Recipe:: volume_default
#
# Copyright (C) 2015 RightScale Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


if node['rsc_mongodb']['use_storage'] == 'true'
node.default['rs-storage']['device']['nickname'] = "#{node['rsc_mongodb']['volume_nickname']}"
node.default['rs-storage']['device']['volume_size'] = "#{node['rsc_mongodb']['volume_size']}"
node.default['rs-storage']['device']['filesystem'] = "#{node['rsc_mongodb']['volume_filesystem']}"
node.default['rs-storage']['device']['mount_point'] = "#{node['rsc_mongodb']['volume_mount_point']}"

#installs right_api_client
include_recipe 'rightscale_volume::default'
include_recipe 'rs-storage::volume'

#when using volumes we set the datadir to the mount point.
node.default[:mongodb][:config][:dbpath] = "#{node.default['rs-storage']['device']['mount_point']}"

end
