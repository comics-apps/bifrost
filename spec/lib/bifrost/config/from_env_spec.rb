describe Bifrost::Config::FromEnv do
  describe ".call" do
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

    it "parse DATABASE_URL with postgres" do
      result = Bifrost::Config::FromEnv.call(prefix)
      expect(result).to eq(expected_result)
    end
  end
end
