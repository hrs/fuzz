require "spec_helper"

describe Fuzz::Executable do
  it "raises an error when a binary is missing" do
    unlikely_binary_name = "rohthohh4poh4eesh9aexo1seSheiM"

    binary = Fuzz::Executable.new(unlikely_binary_name)

    expect {
      binary.error_if_missing
    }.to raise_error(Fuzz::MissingExecutableError)
  end
end
