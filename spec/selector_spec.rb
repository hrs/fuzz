require "spec_helper"

describe Fuzz::Selector do
  describe "#pick" do
    it "delegates selection to the supplied picker" do
      title = "title"
      object = double("object", to_s: title)
      entry = double(
        "entry",
        object: object,
        to_s: title,
      )
      picker = spy("picker", pick: title)
      selector = Fuzz::Selector.new(
        [entry],
        picker: picker,
      )

      expect(selector.pick).to eq(entry)
      expect(picker).to have_received(:pick)
    end

    context "no entry is selected" do
      it "returns the default object" do
        picker = double("picker", pick: nil)
        default = double("default")
        selector = Fuzz::Selector.new(
          [],
          default: default,
          picker: picker,
        )

        expect(selector.pick).to eq(default)
      end

      it "returns nil if no default is supplied" do
        picker = double("picker", pick: nil)
        selector = Fuzz::Selector.new(
          [],
          picker: picker,
        )

        expect(selector.pick).to be_nil
      end
    end

    it "increments the chosen entry in the cache" do
      title = "title"
      object = double("object", to_s: title)
      entry = double(
        "entry",
        object: object,
        to_s: title,
      )
      picker = spy("picker", pick: title)
      cache = spy("cache", increment: nil)
      selector = Fuzz::Selector.new(
        [entry],
        cache: cache,
        picker: picker,
      )

      selector.pick

      expect(cache).to have_received(:increment).with(title)
    end
  end
end
