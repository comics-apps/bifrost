describe Bifrost::Config do
  describe ".from_env_url" do
    it "is defined" do
      Bifrost::Config.respond_to?(:from_env_url)
    end
  end

  describe ".from_yaml_file" do
    it "is defined" do
      Bifrost::Config.respond_to?(:from_yaml_file)
    end
  end
end