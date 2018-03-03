require "spec_helper"

describe Fuzz::Cache do
  def with_temporary_cache
    temp_file_path = "/tmp/fuzz_ruby_test_cache"
    File.open(temp_file_path, "w") do |file|
      file.write("2 existing entry\n")
    end

    yield temp_file_path
  ensure
    File.delete(temp_file_path)
  end

  describe "#weight" do
    it "returns the weight associated with the title" do
      with_temporary_cache do |path|
        cache = Fuzz::Cache.new(path)

        expect(cache.weight("existing entry")).to eq(2)
      end
    end

    it "returns 0 if the object isn't cached" do
      with_temporary_cache do |path|
        cache = Fuzz::Cache.new(path)

        expect(cache.weight("missing item")).to be_zero
      end
    end
  end

  describe "#increment" do
    it "increments the weight of the associated entry" do
      with_temporary_cache do |path|
        cache = Fuzz::Cache.new(path)
        expect(cache.weight("existing entry")).to eq(2)

        cache.increment("existing entry")

        expect(cache.weight("existing entry")).to eq(3)
      end
    end

    it "writes the new entry to the cache file" do
      with_temporary_cache do |path|
        cache = Fuzz::Cache.new(path)

        cache.increment("new entry")

        expect(cache.weight("new entry")).to eq(1)
      end
    end
  end
end
