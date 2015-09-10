class Chef::Recipe
  include Chef::MachineTagHelper
end

members = []

sets = tag_search(node, "mongodb:replicaset=#{node[:rsc_mongodb][:config][:replset]}")

sets.each do | set |

	hostname = set['server:hostname'].first.value + ':27018'
	tags = {}

	set['mongo_tag'].each do | tag |
		tags[tag.predicate] = tag.value
	end

	members << {
		:host => hostname,
		:tags => tags
	}
end

members.sort! { |a,b| a[:host] <=> b[:host] }

Chef::Log.info "replicaset members " + members.inspect


mongodb_replicaset node['mongodb']['replicaset'] do
  members members
end
