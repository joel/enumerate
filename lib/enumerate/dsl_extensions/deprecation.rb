# frozen_string_literal: true

module Enumerate
  module DslExtensions
    module Deprecation
      module ClassMethods
        def enumeration_value(key, value, metadata: {})
          ActiveSupport::Deprecation.warn("`enumeration_value` is deprecated and will be removed in a future release. Please use `enum` instead.")

          enum(key, value)
        end
      end
    end
  end
end
