marker "recipe_start"
# cent os detection and creation of repos
if node[:platform_family].include?("rhel")
  Chef::Log.info 'centos'
# default ubuntu code
else
  Chef::Log.info 'ubuntu'
end
