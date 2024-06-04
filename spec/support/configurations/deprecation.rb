# frozen_string_literal: true

require "active_support/testing/deprecation"

RSpec.configure do |config|
  config.include ActiveSupport::Testing::Deprecation
end
