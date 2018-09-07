module Bifrost
  module Connect
    module Mongo
      def self.call(config)
        require "mongo" unless defined?(::Mongo::Client)

        host = config.delete(:host)
        port = config.delete(:port)

        ::Mongo::Client.new(["#{host}:#{port}"], config)
      end
    end
  end
end
