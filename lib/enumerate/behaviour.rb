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
        Dir["#{File.dirname(__FILE__)}/behaviours/*.rb"].each { |file| require file }

        [
          Behaviours::EnumerationClassHelper,
          Behaviours::StoreEnumerationClass
        ].each do |extra_behaviour|
          extra_behaviour.call(self, attribute_name, options)
        end
      end
    end
  end
end
