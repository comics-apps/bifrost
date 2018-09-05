require_relative "config/from_env_url"
require_relative "config/from_yaml_file"

module Bifrost
  module Config
    extend FromEnvUrl
    extend FromYamlFile
  end
end