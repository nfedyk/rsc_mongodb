#
# Cookbook Name:: rsc_skeleton_cookbook
# Recipe:: default
#
# Copyright (C) 2014 RightScale Inc
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

include_recipe 'build-essential::default'

node.default[:mongodb][:config][:replSet] = "#{node[:rsc_mongodb][:replicaset]}"

#fix bug with name change mongodb vs mongod .conf
node.override['mongodb']['default_init_name'] = 'mongod'

include_recipe 'mongodb::mongodb_org_repo'
include_recipe 'machine_tag::default'
include_recipe 'mongodb::default'

node.default[:mongodb][:config][:replset] = "#{node[:rsc_mongodb][:replicaset]}"

#Tag host with replica set name
machine_tag "mongodb:replicaset=#{node[:rsc_mongodb][:replicaset]}" do
   action :create
end

#if we are using volumes, set up backups on all nodes.
#the cron script will check if it running on a secondary 
if node['rsc_mongodb']['use_storage'] == 'true'

#mongo --quiet --eval "d=db.isMaster(); print( d['ismaster'] );"
#if true , exit. false run the backups.


end
