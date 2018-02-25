require "coveralls"
Coveralls.wear!

require "bundler/setup"
require "fuzz"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Explicitly disable `should` syntax.
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
