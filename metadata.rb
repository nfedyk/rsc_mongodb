name             'rsc_mongodb'
maintainer       'RightScale Inc'
maintainer_email 'premium@rightscale.com'
license          'Apache 2.0'
description      'Installs/Configures Mongo DB'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'build-essential'
depends 'mongodb'
depends 'machine_tag'

recipe 'rsc_mongodb::default', 'Installs mongodb'
recipe 'rsc_mongodb::replicaset', 'configures nodes into a replicaset'

attribute 'rsc_mongodb/replicaset',
   :display_name => 'MongoDB ReplicaSet Name',
   :description => 'The replicaset name to use for the mongodb replica',
   :required => "required",
   :recipes => ['rsc_mongodb::default']

# node[:mongodb][:cluster_name]

# Set to true to make node an arbiter.
# node[:mongodb][:replica_arbiter_only]
# attribute "rsc_mongodb/config/replica_arbiter_only",
#  :display_name => "Arbiter Only",
#  :description => "Set to true to make node an arbiter",
#  :required => "optional",
#  :recipes => ["rsc_mongodb::default"]


# Set to false to omit index creation.
# node[:mongodb][:replica_build_indexes]

# Set to true to hide node from replicaset.
# node[:mongodb][:replica_hidden]

# Number of seconds to delay slave replication.
# node[:mongodb][:replica_slave_delay] - Number of seconds to delay slave replication.

# Node priority.
# node[:mongodb][:replica_priority]

# Node tags.
# node[:mongodb][:replica_tags]

# Number of votes node will cast in an election.
# node[:mongodb][:replica_votes]
