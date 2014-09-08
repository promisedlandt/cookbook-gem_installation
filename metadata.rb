name             "gem_installation"
maintainer       "Nils Landt"
maintainer_email "cookbooks@promisedlandt.de"
license          "MIT"
description      "Installs ruby gems and their dependencies"
long_description IO.read(File.join(File.dirname(__FILE__), "README.md"))
version          "2.0.1"

%w(apt build-essential).each { |dep| depends dep }

%w(debian ubuntu).each { |os| supports os }
