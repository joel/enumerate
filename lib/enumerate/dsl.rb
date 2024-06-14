# frozen_string_literal: true

module Enumerate
  class Dsl
    def self.inherited(subclass)
      subclass.class_attribute :entries
      subclass.entries = {}

      subclass.attr_reader :attribute_name, :options

      subclass.include(InstanceMethods)
      subclass.extend(ClassMethods)

      super
    end

    def initialize(attribute_name, options = {})
      @attribute_name = attribute_name
      @options = options
    end

    module ClassMethods
      # e.g. enums single: { value: 1 }, married: { value: 2 }, divorced: { value: 3 }, widowed: { value: 4 }
      def enums(entries)
        entries.each do |key, value|
          enum(key, value)
        end
      end

      # e.g. enum :single, { value: 1 }
      def enum(name, value_maybe_hash)
        self.entries = entries.merge(name => value_maybe_hash)

        define_helpers_methods(name)
      end

      def define_helpers_methods(name)
        define_singleton_method(name) do
          entries[name]
        end

        define_method(name) do
          entries[name]
        end
      end
    end

    module InstanceMethods
      def translation(name)
        I18n.t(translation_key(name))
      end

      # en:
      #   enumerations:
      #     relationship_status:
      #       single: Person single
      def translation_key(name)
        [
          "enumerations",
          attribute_name.to_s.underscore,
          name
        ].compact.join(".")
      end
    end
  end
end
