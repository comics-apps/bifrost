require_relative "bifrost/config"
require_relative "bifrost/connect"

module Bifrost
  def self.config(path: nil, uri: nil, prefix: nil)
    {}.yield_self { |c| path ? c.merge(Config::FromYamlFile.call(path)) : c }
      .yield_self { |c| uri ? c.merge(Config::FromEnvUrl.call(uri)) : c }
      .yield_self { |c| prefix ? c.merge(Config::FromEnv.call(prefix)) : c }
  end

  def self.connect(datasource, config)
    case datasource
    when :postgres
      @postgres = Connect::Postgres.call(config)
    when :mongo
      @mongo = Connect::Mongo.call(config)
    else
      raise "Please choose :postgres or :mongo as first argument"
    end
  end

  def self.postgres
    @postgres
  end

  def self.mongo
    @mongo
  end
end
