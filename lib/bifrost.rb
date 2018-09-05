require_relative "bifrost/config"

module Bifrost
  def self.config(path: nil, uri: nil)
    {}.yield_self { |c| path ? c.merge(Config::FromYamlFile.call(path)) : c }
      .yield_self { |c| uri ? c.merge(Config::FromEnvUrl.call(uri)) : c }
  end
end
