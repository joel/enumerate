# frozen_string_literal: true

module Enumerate
  class Dsl
    def self.inherited(subclass)
      subclass.class_attribute :entries
      subclass.entries = {}

      subclass.attr_reader :attribute_name, :options

      subclass.include(InstanceMethods)
      subclass.extend(ClassMethods)

      %i[
        translatable
        helper_methods
        deprecation
        accessor_methods
      ].each do |plugin_name|
        require "enumerate/dsl_extensions/#{plugin_name.to_s.underscore}"

        plugin = "Enumerate::DslExtensions::#{plugin_name.to_s.camelize}".constantize

        subclass.include(plugin::InstanceMethods) if plugin.const_defined?(:InstanceMethods)
        subclass.extend(plugin::ClassMethods) if plugin.const_defined?(:ClassMethods)
      end

      super
    end

    def initialize(attribute_name, options = {})
      @attribute_name = attribute_name
      @options = options
    end

    module ClassMethods
      # e.g. enumeration_values single: { value: 1 }, married: { value: 2 }, divorced: { value: 3 }, widowed: { value: 4 }
      def enumeration_values(entries)
        entries.each do |key, value|
          enumeration_value(key, value)
        end
      end

      # e.g. enumeration_value :single, { value: 1 }
      def enumeration_value(name, value_maybe_hash)
        self.entries = entries.merge(name => value_maybe_hash)
      end
    end

    module InstanceMethods
    end
  end
end
