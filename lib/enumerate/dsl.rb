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
          self.class.send(name)
        end
      end
    end

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
