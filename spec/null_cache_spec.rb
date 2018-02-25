describe Fuzz::NullCache do
  describe "#weight" do
    it "always returns 0" do
      null_cache = Fuzz::NullCache.new

      weight = null_cache.weight(double)

      expect(weight).to be_zero
    end
  end
end
