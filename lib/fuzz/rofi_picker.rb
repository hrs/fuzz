class Fuzz::RofiPicker
  def pick(keys)
    assert_executable_available

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
