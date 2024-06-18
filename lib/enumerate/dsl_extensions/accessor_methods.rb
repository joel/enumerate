# frozen_string_literal: true

module Enumerate
  module DslExtensions
    module AccessorMethods
      module ClassMethods
        def enumeration_value(name, value_maybe_hash)
          super

          define_accessor_methods(name)
        end

        private

        def define_accessor_methods(name)
          singleton_class.define_method(:"#{name}=") do |value|
            entries[name][:value] = value
          end

          define_method(:"#{name}=") do |value|
            self.class.send(:"#{name}=", value)
          end
        end
      end
    end
  end
end
