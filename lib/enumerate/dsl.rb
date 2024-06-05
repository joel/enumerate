# frozen_string_literal: true

require "active_support/all"

module Enumerate
  module Dsl
    extend ActiveSupport::Concern

    included do
      class_attribute :entries, instance_writer: false, instance_reader: false
      self.entries = {}
    end

    class_methods do
      # e.g. enums status: { value: 1 }, role: { value: 2 }
      # e.g. enums status: 1, role: 2
      def enums(entries)
        entries.each do |name, value|
          enum(name, value)
        end
      end

      # e.g. enum :status, { value: 1 }
      # e.g. enum :status, 1
      def enum(name, value_maybe_hash)
        name = name.to_sym
        case value_maybe_hash
        when Hash
          raise ArgumentError, _("missing value key in options") unless value_maybe_hash.key?(:value)

          self.entries = entries.merge(name => value_maybe_hash)
        else
          self.entries = entries.merge(name => { value: value_maybe_hash })
        end

        define_enum_methods(name)
      end

      def define_enum_methods(name)
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
      end
    end
  end
end
