marker "recipe_start"
# cent os detection and creation of repos
if node[:platform_family].include?("rhel")
  Chef::Log.info 'centos'
# default ubuntu code
else
  Chef::Log.info 'ubuntu'
end
case platform
when "ubuntu"
  set[:web_apache][:config_subdir] = "apache2"
when "centos", "redhat"
  set[:web_apache][:config_subdir] = "httpd"
end
