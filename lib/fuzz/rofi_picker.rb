class Fuzz::RofiPicker
  def initialize
    assert_executable_available
  end

  def pick(keys)
    `echo "#{ keys.join("\n") }" | #{ command }`.strip
  end

  private

  def command
    "rofi -show run -matching fuzzy -dmenu -i"
  end

  def assert_executable_available
    if !installed?
      raise "Can't find the `rofi` executable!"
    end
  end

  def installed?
    `which rofi`
    $?.success?
  end
end
