# frozen_string_literal: true

module Enumerate
  module Behaviours
    class VirtualAccessors
      class << self
        def call(receiver, attribute_name, options)
          return unless options[:column]

          define_virtual_accessor(receiver, attribute_name, options[:column])
        end

        private

        def define_virtual_accessor(receiver, attribute_name, column_name)
          receiver.define_method(:"#{attribute_name}=") do |value|
            public_send(:"#{column_name}=", value)
          end

          receiver.define_method(attribute_name) do
            public_send(column_name)
          end
        end
      end
    end
  end
end
