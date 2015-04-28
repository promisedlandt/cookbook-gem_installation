module GemInstallationLibrary
  module Dependencies
    GEM_DEPENDENCIES = {
      %w(fog bitlbee_config) => {
        gems: %w(nokogiri)
      },
      "nokogiri" => {
        %w(debian ubuntu) => {
          "default" => %w(libxslt-dev libxml2-dev)
        }
      }
    }.freeze

    def dependencies_for_gem(gem_name)
      if gem_dependencies.values.keys.include?(gem_name)
        Array(value_for_platform(gem_dependencies.values[gem_name]))
      else
        Chef::Log.debug "No dependencies found for #{ gem_name }. This might mean the gem has no dependencies, or its dependencies are not known to this cookbook"
        []
      end
    end

    def gem_dependencies
      @gem_dependencies ||= GemDependencies.new(GEM_DEPENDENCIES)
    end

    class GemDependencies
      attr_reader :values, :gems_to_postprocess

      def initialize(dependency_hash)
        require "deep_merge" # not pretty, but doesn't even register compared to the resolver shit

        @values = solve_dependency_hash(dependency_hash)
      end

      # Let's build the worst dependency resolver in the history of mankind, right in an initialize method
      # TODO kill everyone who sees this
      # rubocop:disable MethodLength,AbcSize
      def solve_dependency_hash(dependency_hash)
        result = dependency_hash.each_with_object({}) do |(gem_names, dependencies), values|
          Array(gem_names).each do |gem_name|
            values[gem_name.to_s] = dependencies
          end
        end

        until (gems_to_postprocess = result.select { |_gem_name, dependencies| dependencies[:gems] }).empty?
          gems_to_postprocess.each do |gem_name, dependencies|
            # We could already be done since multiple gems can have a reference to the same dependencies, when specified as an array of keys in GEM_DEPENDENCIES
            next unless dependencies[:gems]

            # Add the dependencies' dependencies, be they gems or packages
            dependencies[:gems].dup.each do |dep_name|
              result[gem_name][:gems].delete(dep_name)
              result[gem_name][:gems] += result[dep_name][:gems] if result[dep_name][:gems]
              result[gem_name].deep_merge!(result[dep_name])
            end

            result[gem_name].delete :gems
          end
        end

        result
      end
      # rubocop:enable MethodLength,AbcSize
    end
  end
end
