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
      # e.g. enumeration_values :single, :married, :divorced, :widowed
      # e.g. enumeration_values single: 1, married: 2, divorced: 3, widowed: 4
      # e.g. enumeration_values single: { value: 1 }, married: { value: 2 }, divorced: { value: 3 }, widowed: { value: 4, metadata: { key: "value" } }
      def enumeration_values(*entries)
        values =
          if entries.first.is_a?(Hash) # Hash format
            entries.first
          elsif entries.all?(Symbol) # Symbol list format
            entries
          end

        case values
        in Hash => hash_entries
          hash_entries.each { |name, value_maybe_hash| enumeration_value(name, value_maybe_hash) }
        in Array => array_entries
          array_entries.each_with_index { |name, index| enumeration_value(name, { value: index + 1 }) }
        in Symbol, String => name
          enumeration_value(name, name.to_s.upcase) # Default to uppercase string if only name provided
        else
          raise ArgumentError, _("Invalid enums format")
        end
      end

      # e.g. enumeration_value :single, value: 1
      # e.g. enumeration_value :single, { value: 1, metadata: { key: "value" } }
      def enumeration_value(name, hash_value)
        case hash_value
        in Integer => value
          self.entries = entries.merge(name => { value: })
        in Symbol, String => value
          self.entries = entries.merge(name => { value: value.to_s })
        in Hash => hash_value
          raise ArgumentError, _("Invalid enum value format") unless hash_value.key?(:value)

          self.entries = entries.merge(name => hash_value)
        else

          raise ArgumentError, _("Invalid enum value format")
        end
      end
    end

    module InstanceMethods
    end
  end
end
