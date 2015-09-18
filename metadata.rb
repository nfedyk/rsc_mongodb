name             'rsc_mongodb'
maintainer       'RightScale Inc'
maintainer_email 'premium@rightscale.com'
license          'Apache 2.0'
description      'Installs/Configures Mongo DB'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.1'

depends 'build-essential'
depends 'mongodb'
depends 'machine_tag'
depends 'rs-storage'
depends 'rightscale_backup'
depends 'rightscale_volume'

recipe 'rsc_mongodb::default', 'Installs mongodb and sets the replicaset name'
recipe 'rsc_mongodb::replicaset', 'configures nodes into a replicaset'
recipe 'rsc_mongodb::volume_default', 'creates , attaches and formats a volume'
recipe 'rsc_mongodb::mongodb_backup', 'backsup the mongodb volume on secondary nodes'

attribute 'rsc_mongodb/replicaset',
   :display_name => 'MongoDB ReplicaSet Name',
   :description => 'The replicaset name to use for the mongodb replica',
   :required => 'required',
   :category => 'MongoDB',
   :type => 'string',
   :recipes => ['rsc_mongodb::default', 'rsc_mongodb::replicaset']

attribute 'rsc_mongodb/use_storage',
  :display_name => 'Enable volumes',
  :description => 'Enables the use of volumes for the Mongodb datadir',
  :required => 'optional',
  :category => 'MongoDB',
  :default => 'false',
  :type => 'string',
  :recipes => ['rsc_mongodb::volume_default']

attribute 'rsc_mongodb/volume_nickname',
  :display_name => 'Volume Name',
  :description => 'Name of the volume',
  :required => 'optional',
  :category => 'MongoDB',
  :default => 'mongodb_data_volume',
  :type => 'string',
  :recipes => ['rsc_mongodb::volume_default']

attribute 'rsc_mongodb/volume_size',
  :display_name => 'Volume Size',
  :description => 'the size of the volume to create',
  :required => 'optional',
  :category => 'MongoDB',
  :default => '10',
  :type => 'string',
  :recipes => ['rsc_mongodb::volume_default']

attribute 'rsc_mongodb/volume_filesystem',
  :display_name => 'Volume Filesystem',
  :description => 'the filesystem size',
  :required => 'optional',
  :category => 'MongoDB',
  :default => 'ext4',
  :type => 'string',
  :recipes => ['rsc_mongodb::volume_default']

attribute 'rsc_mongodb/volume_mount_point',
  :display_name => 'Volume Mount Point ',
  :description => 'the location to mount the volume',
  :required => 'optional',
  :category => 'MongoDB',
  :default => '/var/lib/mongodb',
  :type => 'string',
  :recipes => ['rsc_mongodb::volume_default']


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
