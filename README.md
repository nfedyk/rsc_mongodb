# rs-storage cookbook

[![Release](https://img.shields.io/github/release/rightscale-cookbooks/rs-storage.svg?style=flat)][release]
[![Build Status](https://img.shields.io/travis/rightscale-cookbooks/rs-storage.svg?style=flat)][travis]

[release]: https://github.com/rightscale-cookbooks/rs-storage/releases/latest
[travis]: https://travis-ci.org/rightscale-cookbooks/rs-storage

Provides recipes for managing volumes on a Server in a RightScale supported cloud which include:

* Creation of single and multi-stripe volumes
* Taking backups of volumes

Github Repository: [https://github.com/rightscale-cookbooks/rs-storage](https://github.com/rightscale-cookbooks/rs-storage)

# Requirements

* Requires Chef 11 or higher
* Platform
  * Ubuntu 12.04
* Cookbooks
  * [chef_handler](http://community.opscode.com/cookbooks/chef_handler)


# Usage

## Creating a new volume

To create a new volume, run the `rs-storage::volume` recipe with the following attributes set:

- `node['rs-storage']['device']['nickname']` - the nickname of the volume

This will create a new volume, attach it to the server, format it with the filesystem specified, and mount it on the
location specified.

# Attributes

- `node['rs-storage']['device']['nickname']` - The nickname for the device or the logical volume comprising multiple of
  devices. Default is `'data_storage'`.


# Recipes

## `rs-storage::default`

Simply includes the `rightscale_volume::default` and `rightscale_backup::default` recipes to meet the requirements of
using the resources in these cookbooks.



# Author

Author:: RightScale Inc (<premium@rightscale.com>)
