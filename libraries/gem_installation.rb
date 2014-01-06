module GemInstallation
  module Dependencies
    GEM_DEPENDENCIES = {
      ["nokogiri", "fog"] => {
        ["debian", "ubuntu"] => {
          "default" => %w(libxslt-dev libxml2-dev)
        }
      }
    }.freeze

    def dependencies_for_gem(gem_name)
      if gem_dependencies.values.keys.include?(gem_name)
        Array(value_for_platform(gem_dependencies.values[gem_name]))
      else
        Chef::Log.warn "No dependencies found for #{ gem_name }. This might mean the gem has no dependencies, or its dependencies are not known to this cookbook"
        []
      end
    end

    def gem_dependencies
      @gem_dependencies ||= GemDependencies.new(GEM_DEPENDENCIES)
    end

    class GemDependencies
      attr_reader :values
      def initialize(dependency_hash)
        @values = {}

        dependency_hash.each do |gem_names, dependencies|
          Array(gem_names).each do |gem_name|
            @values[gem_name.to_s] = dependencies
          end
        end
      end
    end

  end
end
