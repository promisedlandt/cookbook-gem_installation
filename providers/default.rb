action :install do
  gem_installation_dependencies new_resource.gem_name do
    action :install
  end

  gem_package new_resource.gem_name
end

action :install_before_convergence do
  gem_installation_dependencies new_resource.gem_name do
    action :nothing
  end.run_action(:install_before_convergence)

  # gem installation before convergence
  chef_gem new_resource.gem_name
  require new_resource.gem_name
end
