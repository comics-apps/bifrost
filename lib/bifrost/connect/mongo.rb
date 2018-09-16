module Bifrost
  module Connect
    module Mongo
      def self.call(config)
        require "mongo" unless defined?(::Mongo::Client)

        host = config.delete(:host)
        port = config.delete(:port)
        options = config
        options.delete(:adapter)

        ::Mongo::Client.new(["#{host}:#{port}"], options)
      end
    end
  end
end
