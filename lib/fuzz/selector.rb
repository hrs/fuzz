require_relative "cache"
require_relative "entry"
require_relative "rofi_picker"
require_relative "null_cache"

class Fuzz::Selector
  def initialize(items, options = {})
    @cache = options.fetch(:cache, Fuzz::NullCache.new)
    @default = options.fetch(:default, nil)
    @picker = options.fetch(:picker, Fuzz::RofiPicker.new)
    @entries = items.map { |item| make_entry(item, @cache) }
  end

  def pick
    title = picker.pick(titles)
    chosen_entry = find_entry_by_title(title)

    if chosen_entry.nil?
      default
    else
      cache.increment!(chosen_entry.title)
      chosen_entry.object
    end
  end

  private

  attr_reader(
    :cache,
    :default,
    :entries,
    :picker,
  )

  def titles
    entries.sort.map(&:title)
  end

  def find_entry_by_title(title)
    entries.detect { |entry| entry.title == title }
  end

  def make_entry(item, cache)
    Fuzz::Entry.new(
      title: item.to_s,
      object: item,
      weight: cache.weight(item.to_s) || 0,
    )
  end
end
