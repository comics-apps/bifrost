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

    context "with :prefix option" do
      let(:prefix) { "DATABASE" }
      let(:expected_result) do
        {
          adapter: "fake-adapter",
        }
      end

      before do
        ENV["DATABASE_ADAPTER"] = "fake-adapter"
      end

      after do
        ENV.delete("DATABASE_ADAPTER")
      end

      it "returns config from ENV" do
        result = Bifrost.config(prefix: prefix)
        expect(result).to eq(expected_result)
      end
    end

    context "with :path, :uri and :prefix options" do
      let(:path) { File.join(__dir__, "../fixtures/config.yml") }
      let(:prefix) { "DATABASE" }
      let(:uri) { "postgres://user:pass@local:2345/dbname" }

      let(:expected_result) do
        {
          adapter: "fake-adapter",
          username: "user",
          password: "pass",
          host: "local",
          port: 2345,
          database: "dbname",
          pool: 100
        }
      end

      before do
        ENV["DATABASE_ADAPTER"] = "fake-adapter"
      end

      after do
        ENV.delete("DATABASE_ADAPTER")
      end

      it "returns merged config from ENV and file" do
        result = Bifrost.config(path: path, uri: uri, prefix: prefix)
        expect(result).to eq(expected_result)
      end
    end
  end

  describe ".connect" do
    before do
      if Bifrost.instance_variables.include?(:@mongo)
        Bifrost.remove_instance_variable(:@mongo)
      end

      if Bifrost.instance_variables.include?(:@postgres)
        Bifrost.remove_instance_variable(:@postgres)
      end
    end

    context "with :mongo datasource" do
      it "calls connection with mongo" do
        expect(Bifrost::Connect::Mongo).to receive(:call).with({})

        Bifrost.connect(:mongo, {})
      end

      it "cache connection" do
        allow(Bifrost::Connect::Mongo)
          .to receive(:call).with({}).and_return(:mongo)

        Bifrost.connect(:mongo, {})

        expect(Bifrost.instance_variables).to eq([:@mongo])
        expect(Bifrost.instance_variable_get(:@mongo)).to eq(:mongo)
      end
    end

    context "with :postgres datasource" do
      it "calls connection with mongo" do
        expect(Bifrost::Connect::Postgres).to receive(:call).with({})

        Bifrost.connect(:postgres, {})
      end

      it "cache connection" do
        allow(Bifrost::Connect::Postgres)
          .to receive(:call).with({}).and_return(:postgres)

        Bifrost.connect(:postgres, {})

        expect(Bifrost.instance_variables).to eq([:@postgres])
        expect(Bifrost.instance_variable_get(:@postgres)).to eq(:postgres)
      end
    end

    context "with other datasource" do
      it "raises error" do
        expect {
          Bifrost.connect(:foo, {})
        }.to raise_error(RuntimeError)
               .with_message(
                 "Please choose :postgres or :mongo as first argument"
               )
      end
    end
  end

  describe ".mongo" do
    before do
      allow(Bifrost::Connect::Mongo)
        .to receive(:call).and_return(:mongo)
    end

    it "retuns cached connection" do
      Bifrost.connect(:mongo, {})

      expect(Bifrost.mongo).to eq(:mongo)
    end
  end

  describe ".postgres" do
    before do
      allow(Bifrost::Connect::Postgres)
        .to receive(:call).and_return(:postgres)
    end

    it "retuns cached connection" do
      Bifrost.connect(:postgres, {})

      expect(Bifrost.postgres).to eq(:postgres)
    end
  end
end