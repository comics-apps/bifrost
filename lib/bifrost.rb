require_relative "bifrost/config"

module Bifrost
  def self.config(path: nil, uri: nil, prefix: nil)
    {}.yield_self { |c| path ? c.merge(Config::FromYamlFile.call(path)) : c }
      .yield_self { |c| uri ? c.merge(Config::FromEnvUrl.call(uri)) : c }
      .yield_self { |c| prefix ? c.merge(Config::FromEnv.call(prefix)) : c }
  end
end
