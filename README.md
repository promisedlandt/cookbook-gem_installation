# Description

Provides a set of LWRPs to install ruby gems and/or their package dependencies, before or during convergence.  
If you are sick and tired of manually installing libxml2-dev and libxslt-dev, this cookbook is dedicated to you.

Does not install the rubygems binary.

You probably don't want to use this, it's not well done and semi abandoned, but I haven't found a better solution yet.

# Update notes from previous versions

 * You must include the `gem_installation::default` recipe now. This is the sad result of some internal rejiggering

# Warning

Currently, the prerequisites are hardcoded in libraries/gem_installation.rb

While a solution utilizing a dependency solver would be great, for now this is much better than nothing, and the LWRP interface is unlikely to change anyway.

# Platforms

Ubuntu and Debian. Check [.kitchen.yml](https://github.com/promisedlandt/cookbook-gem_installation/blob/master/.kitchen.yml) for the exact versions tested.

# Examples

```
# Set up everything this cookbook needs
include_recipe "gem_installation::default"

# Install fog before convergence so you can use it in your chef recipes
gem_installation "fog"

# Install fog during convergence
gem_installation "nokogiri" do
  action :install
end

# Install the nokogiri dependencies during convergence (e.g. because you deploy a Ruby application that has nokogiri in it's bundle).
# Note: does not install nokogiri itself, only the dependencies
gem_installation_dependencies "nokogiri" 

# Install fog dependencies before convergence (e.g. because you include a third party cookbook that will install fog as a chef_gem).
# Once again, the fog gem itself is not installed
gem_installation_dependencies "fog" do
  action :install_before_convergence
end
```

# Recipes

## gem_installation::default

Installs the [deep_merge](https://github.com/danielsdeleo/deep_merge) gem, which this cookbook depends on.

Also includes build-essential, so you're able to build native extensions.

# Attributes

Currently, no attributes are used by this cookbook.

# Resources / Providers

Note that the default actions for the two LWRPs are the opposite of each other.  
While this is inconsistent, it reflects the expected use cases.

## gem_installation

Deals with gem installation, including dependencies

### Attributes

Attribute | Description | Type | Default
----------|-------------|------|--------
gem_name | Name of the gem to install | String | name
compile_time | Same as the `compile_time` flag on chef_gem resource. Only works with `:install_before_convergence` action | Boolean | true

### Actions

Name | Description | Default
-----|-------------|--------
install_before_convergence | Installs the named gem as a chef_gem | yes
install | Installs the named gem using gem_package |

## gem_installation_dependencies

Install only gem dependencies, not the gems themselves.

### Attributes

Attribute | Description | Type | Default
----------|-------------|------|--------
gem_name | Dependencies of this gem will be installed | String | name

### Actions

Name | Description | Default
-----|-------------|--------
install | Installs prerequisites during convergence | yes
install_before_convergence | Installs prerequisites before convergence |
