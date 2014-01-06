include_recipe "gem_installation::default"

gem_installation_dependencies "nokogiri" do
    action :install_before_convergence
end
