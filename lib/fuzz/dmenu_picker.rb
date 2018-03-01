class Fuzz::DmenuPicker
  def pick(keys)
    assert_executable_available

    `echo "#{ keys.join("\n") }" | #{ command }`.strip
  end

  private

  def command
    "dmenu -i"
  end

  def assert_executable_available
    if !installed?
      raise "Can't find the `dmenu` executable!"
    end
  end

  def installed?
    `which dmenu`
    $?.success?
  end
end
