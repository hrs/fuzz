module Fuzz
  class Entry
    include Comparable

    attr_reader :title, :object, :weight

    def initialize(title:, object:, weight:)
      @title = title
      @object = object
      @weight = weight
    end

    def <=>(other)
      other_weight = other.weight

      if weight != other_weight
        other_weight <=> weight
      else
        title <=> other.title
      end
    end
  end
end
