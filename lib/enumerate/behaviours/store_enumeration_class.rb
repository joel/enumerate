# frozen_string_literal: true

module Enumerate
  module Behaviours
    class StoreEnumerationClass
      class << self
        def call(receiver, attribute_name, options)
          receiver.enumerations[attribute_name] = options[:with]
        end
      end
    end
  end
end
