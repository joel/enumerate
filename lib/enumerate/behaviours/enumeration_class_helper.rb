# frozen_string_literal: true

module Enumerate
  module Behaviours
    class EnumerationClassHelper
      class << self
        def call(receiver, attribute_name, options)
          receiver.enumerations[attribute_name] = enumeration_class_name(attribute_name).constantize.new(attribute_name, options)
        end

        private

        def enumeration_class_name(attribute_name)
          attribute_name.to_s.classify
        end
      end
    end
  end
end
