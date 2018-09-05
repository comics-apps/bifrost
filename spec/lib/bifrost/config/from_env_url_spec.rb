describe Bifrost::Config::FromEnvUrl do
  describe ".from_env_url" do
    context "with postgresql heroku addon" do
      let(:database_url) { "postgres://dbuser:dbpass@localhost:1234/dbname" }
      let(:expected_result) do
        {
          adapter: "postgres",
          username: "dbuser",
          password: "dbpass",
          host: "localhost",
          port: 1234,
          database: "dbname"
        }
      end

      it "parse DATABASE_URL with postgres" do
        result = Bifrost::Config::FromEnvUrl.call(database_url)
        expect(result).to eq(expected_result)
      end
    end

    context "with mongodb heroku addon" do
      let(:database_url) { "mongodb://dbuser:dbpass@localhost:1234/dbname" }
      let(:expected_result) do
        {
          adapter: "mongodb",
          username: "dbuser",
          password: "dbpass",
          host: "localhost",
          port: 1234,
          database: "dbname"
        }
      end

      it "parse DATABASE_URL with postgres" do
        result = Bifrost::Config::FromEnvUrl.call(database_url)
        expect(result).to eq(expected_result)
      end
    end

    context "without username and password" do
      let(:database_url) { "postgres://localhost:1234/dbname" }
      let(:expected_result) do
        {
          adapter: "postgres",
          username: nil,
          password: nil,
          host: "localhost",
          port: 1234,
          database: "dbname"
        }
      end

      it "parse DATABASE_URL with postgres" do
        result = Bifrost::Config::FromEnvUrl.call(database_url)
        expect(result).to eq(expected_result)
      end
    end
  end
end