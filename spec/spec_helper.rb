# frozen_string_literal: true

require "enumerate"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  # focus
  config.filter_run_when_matching :focus

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

Dir[File.join(File.dirname(__FILE__), "support/configurations/**/*.rb")].each do |file_path|
  require file_path
end

Dir[File.join(File.dirname(__FILE__), "support/matchers/**/*.rb")].each do |file_path|
  require file_path
end

Dir[File.join(File.dirname(__FILE__), "support/**/*.rb")].each do |file_path|
  require file_path
end
