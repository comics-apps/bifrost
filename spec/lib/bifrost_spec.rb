describe Bifrost do
  describe ".config" do
    context "with :path option" do
      let(:path) { File.join(__dir__, "../fixtures/config.yml") }

      let(:expected_result) do
        {
          adapter: "postgres",
          username: "dbuser",
          password: "dbpass",
          host: "localhost",
          port: 1234,
          database: "dbname",
          pool: 100
        }
      end

      it "returns config from file" do
        result = Bifrost.config(path: path)
        expect(result).to eq(expected_result)
      end
    end

    context "with :uri option" do
      let(:uri) { "postgres://user:pass@local:2345/dbname" }

      let(:expected_result) do
        {
          adapter: "postgres",
          username: "user",
          password: "pass",
          host: "local",
          port: 2345,
          database: "dbname",
        }
      end

      it "returns config from ENV" do
        result = Bifrost.config(uri: uri)
        expect(result).to eq(expected_result)
      end
    end

    context "with :path and :uri options" do
      let(:path) { File.join(__dir__, "../fixtures/config.yml") }
      let(:uri) { "postgres://user:pass@local:2345/dbname" }

      let(:expected_result) do
        {
          adapter: "postgres",
          username: "user",
          password: "pass",
          host: "local",
          port: 2345,
          database: "dbname",
          pool: 100
        }
      end

      it "returns merged config from ENV and file" do
        result = Bifrost.config(path: path, uri: uri)
        expect(result).to eq(expected_result)
      end
    end
  end
end