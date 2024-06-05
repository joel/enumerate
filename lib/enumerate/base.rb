# frozen_string_literal: true

require "active_support/all"

module Enumerate
  module Base
    extend ActiveSupport::Concern

    included do
      class_attribute :enumerations,   instance_writer: false, instance_reader: false
      class_attribute :attribute_name, instance_writer: false, instance_reader: false
      class_attribute :options,        instance_writer: false, instance_reader: false
    end

    class_methods do
      def has_enumeration_for(attribute_name, options = {})
        self.attribute_name = attribute_name
        self.options        = options
        self.enumerations = ({})

        store_enumeration_class
      end

      private

      def store_enumeration_class
        enumerations[attribute_name] = enumeration_class_name
      end

      def enumeration_class_name
        attribute_name.to_s.classify
      end
    end
  end
end
