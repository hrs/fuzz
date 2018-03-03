module Fuzz
  class MissingExecutableError < StandardError
  end

  class Executable
    def initialize(command)
      @command = command
    end

    def error_if_missing
      if !installed?
        raise(
          MissingExecutableError,
          "Can't find the `#{ command }` executable!",
        )
      end
    end

    private

    attr_reader :command

    def installed?
      system("which #{ command }")
      $?.success?
    end
  end
end
