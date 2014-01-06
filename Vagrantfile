# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.hostname = "gem-installation-berkshelf"

  config.omnibus.chef_version = :latest
  config.cache.auto_detect = true

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "opscode-ubuntu-13.04"

  # Enabling the Berkshelf plugin. To enable this globally, add this configuration
  # option to your ~/.vagrant.d/Vagrantfile file
  config.berkshelf.enabled = true

  config.vm.provision :chef_solo do |chef|
    chef.run_list = [
      "recipe[gem_installation::default]"
    ]
  end
end
