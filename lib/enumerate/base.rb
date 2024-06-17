# frozen_string_literal: true

require "active_support/all"

module Enumerate
  module Base
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
          Behaviours::EnumerationClassHelper
        ].each do |extra_behaviour|
          extra_behaviour.call(self, attribute_name, options)
        end
      end
    end
  end
end
