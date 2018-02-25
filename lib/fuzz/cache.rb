require "fileutils"

class Fuzz::Cache
  def initialize(cache_file)
    @cache_file = File.expand_path(cache_file)
    @entries = cache_entries(@cache_file)
  end

  def weight(title)
    entries.fetch(title, 0)
  end

  def increment!(title)
    entries[title] = weight(title) + 1
    write
  end

  private

  attr_reader :cache_file, :entries

  def write
    File.open(cache_file, "w") do |file|
      entries.each do |title, count|
        file.puts("#{ count } #{ title }")
      end
    end
  end

  def cache_entries(cache_file)
    if File.exist?(cache_file)
      hash_from_file(File.new(cache_file))
    else
      {}
    end
  end

  def hash_from_file(cache_file)
    cache_file.readlines.inject({}) { |hash, line|
      count, title = line.split(" ", 2)
      hash[title.strip] = count.to_i
      hash
    }
  end

  def directory
    File.dirname(cache_file)
  end

  def ensure_directory_exists
    FileUtils.mkdir_p(directory)
  end
end
