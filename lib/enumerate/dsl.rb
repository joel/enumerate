# frozen_string_literal: true

module Enumerate
  class Dsl
    def self.inherited(subclass)
      subclass.class_attribute :entries
      subclass.entries = {}

      subclass.attr_reader :attribute_name, :options

      subclass.include(InstanceMethods)
      subclass.extend(ClassMethods)

      Dir["#{File.dirname(__FILE__)}/plugins/*.rb"].each { |file| require file }

      [
        Plugins::Translatable,
        Plugins::HelperMethods
      ].each do |plugin|
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
      # e.g. enums single: { value: 1 }, married: { value: 2 }, divorced: { value: 3 }, widowed: { value: 4 }
      def enums(entries)
        entries.each do |key, value|
          enum(key, value)
        end
      end

      # e.g. enum :single, { value: 1 }
      def enum(name, value_maybe_hash)
        self.entries = entries.merge(name => value_maybe_hash)

        define_helpers_methods(name) if defined?(Plugins::HelperMethods::ClassMethods)
      end
    end

    module InstanceMethods
    end
  end
end
