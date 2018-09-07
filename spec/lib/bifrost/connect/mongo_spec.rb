require "mongo"

describe Bifrost::Connect::Mongo do
  describe ".call" do
    let(:config) do
      {
        host: "local",
        port: "1234",
        foo: :bar
      }
    end

    let(:hosts) { ["local:1234"] }
    let(:mongo_options) do
      {
        foo: :bar
      }
    end

    it "calls Mongo::Client in proper way" do
      expect(Mongo::Client).to receive(:new).with(hosts, mongo_options)

      Bifrost::Connect::Mongo.call(config)
    end
  end
end
