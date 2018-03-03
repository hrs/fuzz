module Fuzz
  class RofiPicker
    def pick(keys)
      Fuzz::Executable.new("rofi").error_if_missing

      `echo "#{ keys.join("\n") }" | #{ command }`.strip
    end

    private

    def command
      "rofi -show run -matching fuzzy -dmenu -i"
    end
  end
end
