include_recipe "apt" if platform_family?("debian")

node.set["build-essential"]["compile_time"] = true
include_recipe "build-essential"

chef_gem "deep_merge" do
  action :nothing
end.run_action(:install)
