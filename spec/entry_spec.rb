describe Fuzz::Entry do
  describe "#object" do
    it "returns the supplied object" do
      object = double("object")
      entry = Fuzz::Entry.new(
        title: nil,
        object: object,
        weight: nil,
      )

      expect(entry.object).to eq(object)
    end
  end

  describe "#title" do
    it "returns the supplied title" do
      title = double("title")
      entry = Fuzz::Entry.new(
        title: title,
        object: nil,
        weight: nil,
      )

      expect(entry.title).to eq(title)
    end
  end

  describe "#weight" do
    it "returns the supplied weight" do
      weight = double("weight")
      entry = Fuzz::Entry.new(
        title: nil,
        object: nil,
        weight: weight,
      )

      expect(entry.weight).to eq(weight)
    end
  end

  describe "#<=>" do
    it "sorts by weight, heaviest first" do
      entry_1 = Fuzz::Entry.new(
        title: nil,
        object: nil,
        weight: 1,
      )
      entry_2 = Fuzz::Entry.new(
        title: nil,
        object: nil,
        weight: 2,
      )

      expect(entry_2).to be < entry_1
    end

    it "sorts by title if weights are equal" do
      entry_a = Fuzz::Entry.new(
        title: "a",
        object: nil,
        weight: 0,
      )
      entry_b = Fuzz::Entry.new(
        title: "b",
        object: nil,
        weight: 0,
      )

      expect(entry_a).to be < entry_b
    end
  end
end
