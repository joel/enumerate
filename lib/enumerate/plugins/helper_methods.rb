# frozen_string_literal: true

module Enumerate
  module Plugins
    module HelperMethods
      module ClassMethods
        def enum(name, value_maybe_hash)
          super

          define_helpers_methods(name)
        end

        private

        def define_helpers_methods(name)
          define_singleton_method(name) do
            entries[name]
          end

          define_method(name) do
            entries[name]
          end
        end
      end
    end
  end
end
