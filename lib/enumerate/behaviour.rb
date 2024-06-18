# frozen_string_literal: true

module Enumerate
  module Behaviour
    def self.extended(receiver)
      receiver.class_attribute :enumerations, instance_writer: false, instance_reader: false
      receiver.enumerations = {}

      receiver.extend(ClassMethods)

      super
    end

    module ClassMethods
      def has_enumeration_for(attribute_name, options = {})
        %i[
          enumeration_class_helper
          store_enumeration_class
          virtual_accessors
        ].each do |extra_behaviour_name|
          require "enumerate/behaviours/#{extra_behaviour_name.to_s.underscore}"

          extra_behaviour = "Enumerate::Behaviours::#{extra_behaviour_name.to_s.camelize}".constantize

          extra_behaviour.call(self, attribute_name, options)
        end
      end
    end
  end
end
