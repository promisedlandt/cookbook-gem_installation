include_recipe "apt" if platform_family?("debian")

node.set["build_essential"]["compile_time"] = true
include_recipe "build-essential"

# TODO remove when build-essential debian bug is fixed (make not being installed)
#package "make" do
  #action :nothing
#end.run_action(:install)

chef_gem "deep_merge" do
  action :nothing
end.run_action(:install)
