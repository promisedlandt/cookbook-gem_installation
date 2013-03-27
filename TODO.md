Before release:
  * use a depedency resolver to check for all gems that will be installed (does `gem dependency whatever --pipe` resolve the whole graph?)
  * LWRPs should delegate gem_package / chef_gem resource attributes

Useful:
  * find out how to access recipe resource collection in provider (providers/dependencies.rb)
  * research whether rubygems installation would be a useful feature
  * include build_essential, but only if we install a package?

Nice to have:
  * RHEL support

Probably stupid:
  * Windows support

