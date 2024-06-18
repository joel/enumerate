# frozen_string_literal: true

module Enumerate
  module DslExtensions
    module HelperMethods
      module ClassMethods
        def enumeration_value(name, value_maybe_hash)
          super

          define_helpers_methods(name)
        end

        private

        def define_helpers_methods(name)
          define_method(name) do
            entries[name][:value]
          end
        end
      end
    end
  end
end
