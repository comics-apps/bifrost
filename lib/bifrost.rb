require_relative "bifrost/config"

module Bifrost
  def self.config(path: nil, uri: nil)
    {}.yield_self { |c| path ? c.merge(Config.from_yaml_file(path)) : c }
      .yield_self { |c| uri ? c.merge(Config.from_env_url(uri)) : c }
  end
end
