module Fuzz
  class PickPicker
    def pick(keys)
      Fuzz::Executable.new("pick").error_if_missing

      `echo "#{ keys.join("\n") }" | pick`.strip
    end
  end
end
