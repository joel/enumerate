# frozen_string_literal: true

module Enumerate
  module DslExtensions
    module Deprecation
      module ClassMethods
        def associate_values(*)
          ActiveSupport::Deprecation.warn("`associate_values` is deprecated and will be removed in a future release. Please use `enumeration_values` instead.")

          enumeration_values(*)
        end
      end
    end
  end
end
