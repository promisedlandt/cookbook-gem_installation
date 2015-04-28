actions :install, :install_before_convergence

default_action :install_before_convergence

attribute :gem_name, kind_of: String, name_attribute: true
attribute :compile_time, kind_of: [TrueClass, FalseClass], default: true
