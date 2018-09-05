module Bifrost
  module Config
    module FromEnvUrl
      def from_env_url(url)
        parts = url.scan(/^(.+):\/\/((.+)\:(.+)\@){0,1}(.+)\:(.+)\/(.+)$/)[0]

        {
          adapter: parts[0],
          username: parts[2],
          password: parts[3],
          host: parts[4],
          port: parts[5].to_i,
          database: parts[6]
        }
      end
    end
  end
end
