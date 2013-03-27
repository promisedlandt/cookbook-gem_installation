#
# Cookbook Name:: gem_installation
# Recipe:: default
#
# Copyright (C) 2013 Nils Landt
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apt" if platform_family?("debian")
