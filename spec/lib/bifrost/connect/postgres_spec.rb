require "sequel"

describe Bifrost::Connect::Postgres do
  describe ".call" do
    let(:config) do
      {
        host: "local",
        port: "1234",
        foo: :bar
      }
    end

    let(:hosts) { ["local:1234"] }

    it "calls Mongo::Client in proper way" do
      expect(Sequel).to receive(:connect).with(config)

      Bifrost::Connect::Postgres.call(config)
    end
  end
end
