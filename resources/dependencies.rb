actions :install, :install_before_convergence

default_action :install

attribute :gem_name, kind_of: String, name_attribute: true
