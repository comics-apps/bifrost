module Bifrost
  module Connect
    module Postgres
      def self.call(config)
        require "sequel" unless defined?(Sequel)

        Sequel.connect(config)
      end
    end
  end
end
