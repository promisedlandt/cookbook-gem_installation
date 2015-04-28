action :install do
  gem_installation_dependencies new_resource.gem_name do
    action :install
  end

  gem_package new_resource.gem_name

  new_resource.updated_by_last_action(true)
end

action :install_before_convergence do
  gem_installation_dependencies new_resource.gem_name do
    action :nothing
  end.run_action(:install_before_convergence)

  # gem installation before convergence
  chef_gem new_resource.gem_name do
    compile_time new_resource.compile_time if Chef::Resource::ChefGem.method_defined?(:compile_time)
  end
  require new_resource.gem_name

  new_resource.updated_by_last_action(true)
end
