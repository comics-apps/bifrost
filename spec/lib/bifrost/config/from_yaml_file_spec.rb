describe Bifrost::Config::FromYamlFile do
  describe ".from_yaml_file" do
    context "with postgresql heroku addon" do
      let(:path) { File.join(__dir__, "../../../fixtures/config.yml") }

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

      it "returns symbolized config" do
        result = Bifrost::Config::FromYamlFile.call(path)
        expect(result).to eq(expected_result)
      end
    end
  end
end