if platform_family?("debian")
  node.set[:apt][:compile_time_update] = true
  include_recipe "apt"
end

node.set["build-essential"]["compile_time"] = true
include_recipe "build-essential"

chef_gem "deep_merge" do
  action :nothing
  compile_time true if Chef::Resource::ChefGem.method_defined?(:compile_time)
end.run_action(:install)
