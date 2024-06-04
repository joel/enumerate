# frozen_string_literal: true

RSpec::Matchers.define :have_deprecated_warning do |expected|
  supports_block_expectations

  match do |block|
    @old_behavior = ActiveSupport::Deprecation.behavior
    @warnings = []

    ActiveSupport::Deprecation.behavior = lambda do |message, _callstack|
      @warnings << message
    end

    block.call

    ActiveSupport::Deprecation.behavior = @old_behavior

    @warnings.any? { |warning| warning.include?(expected) }
  end

  failure_message do
    "expected a deprecation warning matching #{expected.inspect} but got #{@warnings.inspect}"
  end

  failure_message_when_negated do
    "expected no deprecation warning matching #{expected.inspect} but got #{@warnings.inspect}"
  end
end
