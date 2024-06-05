# frozen_string_literal: true

require "active_support/all"

module Enumerate
  module Dsl
    extend ActiveSupport::Concern

    included do
      class_attribute :entries
      self.entries = {}

      attr_reader :attribute_name, :options
    end

    def initialize(attribute_name, options = {})
      @attribute_name = attribute_name
      @options = options
    end

    class_methods do
      # e.g. enums single: { value: 1 }, married: { value: 2 }, divorced: { value: 3 }, widowed: { value: 4 }
      # e.g. enums single: 1, married: 2, divorced: 3, widowed: 4
      # e.g. enums :single, :married, :divorced, :widowed
      def enums(*entries)
        case entries
        in Hash
          entries.each do |key, value|
            enum(key, value)
          end
        in Array
          entries.each do |key|
            enum(key, nil)
          end
        end
      end

      # e.g. enum :single, { value: 1 }
      # e.g. enum :single, 1
      def enum(name, value_maybe_hash)
        case value_maybe_hash
        in Integer
          self.entries = entries.merge(name => { value: value_maybe_hash })
        in Hash
          raise ArgumentError, _("missing value key in options") unless value_maybe_hash.key?(:value)

          self.entries = entries.merge(name => value_maybe_hash)
        else
          self.entries = entries.merge(name => { value: (entries.values.map { |v| v[:value] }.max.to_i + 1) || 1 })
        end

        # define_helpers_methods(name)
      end

      def define_helpers_methods(name)
        define_singleton_method(name) do
          entries[name]
        end

        define_singleton_method(:"#{name}=") do |value|
          entries[name][:value] = value
        end

        define_singleton_method(:"#{name}_value") do
          send(name).fetch(:value)
        end

        define_singleton_method(:"#{name}_keys") do
          send(name).keys
        end

        define_singleton_method(:"#{name}_translation") do
          value.to_s.tr("_", " ").split.map(&:capitalize).join(" ")
          I18n.t("enumerations.#{name.underscore}.#{value.to_s.underscore}", default: send(:"#{name}_value"))
          I18n.t(key_for_translation)
        end

        # en:
        #   enumerations:
        #     relationship_status:
        #       single: Person single
        define_singleton_method(:"#{name}_translation_key") do
          [
            "enumerations",
            enumeration_class.name.underscore,
            name
          ].compact.join(".")
        end
      end
    end
  end
end
