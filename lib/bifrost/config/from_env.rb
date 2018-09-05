module Bifrost
  module Config
    module FromEnv
      def self.call(prefix)
        config = {
          adapter: ENV["#{prefix}_ADAPTER"],
          username: ENV["#{prefix}_USERNAME"],
          password: ENV["#{prefix}_PASSWORD"],
          host: ENV["#{prefix}_HOST"],
          port: ENV["#{prefix}_PORT"],
          database: ENV["#{prefix}_DATABASE"]
        }

        config.reject{ |k, v| v.nil? }
      end
    end
  end
end
