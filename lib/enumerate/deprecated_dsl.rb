# frozen_string_literal: true

require "active_support/all"

module Enumerate
  module DeprecatedDsl
    extend ActiveSupport::Concern

    class_methods do
      def enumeration_value(key, value, metadata: {})
        ActiveSupport::Deprecation.warn("`enumeration_value` is deprecated and will be removed in a future release. Please use `enum` instead.")

        enum(key, value)
      end
    end
  end
end
