include_recipe "apt" if platform_family?("debian")

node.set["build_essential"]["compiletime"] = true
include_recipe "build-essential"
