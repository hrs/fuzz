module Fuzz
  class DmenuPicker
    def pick(keys)
      Fuzz::Executable.new("dmenu").error_if_missing

      `echo "#{ keys.join("\n") }" | dmenu -i`.strip
    end
  end
end
