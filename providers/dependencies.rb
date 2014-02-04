include ::GemInstallation::Dependencies

action :install do
  dependencies_for_gem(new_resource.gem_name).each do |dependency|
    package dependency
  end

  new_resource.updated_by_last_action(true)
end

action :install_before_convergence do
  dependencies = dependencies_for_gem(new_resource.gem_name)

  unless dependencies.empty?
    # TODO find out how to access recipe resource collection in provider
    # resources(:execute => "apt-get-update").run_action(:run) if platform_family?("debian")
    execute "apt-get update" do
      command "apt-get update"
      ignore_failure true
      action :nothing
    end.run_action(:run)

    dependencies.each do |dependency|
      package dependency do
        action :nothing
      end.run_action(:install)
    end
  end

  new_resource.updated_by_last_action(true)
end
