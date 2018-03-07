module Fuzz
  class PecoPicker
    def pick(keys)
      Fuzz::Executable.new("peco").error_if_missing

      `echo "#{ keys.join("\n") }" | peco`.strip
    end
  end
end
