module Fuzz
  class SelectaPicker
    def pick(keys)
      Fuzz::Executable.new("selecta").error_if_missing

      `echo "#{ keys.join("\n") }" | selecta`.strip
    end
  end
end
