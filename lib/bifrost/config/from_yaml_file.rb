require "yaml"

module Bifrost
  module Config
    module FromYamlFile
      ENVIRONMENT = ENV.fetch("RUBY_ENV", "development").freeze

      def from_yaml_file(path)
        output = {}
        YAML.load_file(path).fetch(ENVIRONMENT).each do |key, value|
          output[key.to_sym] = value
        end
        output
      end
    end
  end
end
