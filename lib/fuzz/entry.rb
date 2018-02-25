class Fuzz::Entry
  include Comparable

  attr_reader :title, :object, :weight

  def initialize(title:, object:, weight:)
    @title = title
    @object = object
    @weight = weight
  end

  def <=>(other)
    if weight != other.weight
      other.weight <=> weight
    else
      title <=> other.title
    end
  end
end
