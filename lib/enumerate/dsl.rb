# frozen_string_literal: true

require "active_support/all"

module Enumerate
  module Dsl
    extend ActiveSupport::Concern

    included do
      class_attribute :_enums
      self._enums = {}
    end

    class_methods do
      def enums(values)
        values.each do |name, options|
          enum(name, options)
        end
      end

      def enum(name, options = {})
        name = name.to_sym
        case options
        when Hash
          raise ArgumentError, _("missing value key in options") unless options.key?(:value)

          self._enums = _enums.merge(name => options) # e.g. enums single: { value: 1 }, married: { value: 2 }, divorced: { value: 3 }
        else
          value = options # e.g. enums single: 1, married: 2, divorced: 3
          self._enums = _enums.merge({ name => { value: } })
        end
        define_enum_methods(name)
      end

      def define_enum_methods(name)
        define_singleton_method(name) do
          _enums[name]
        end

        define_singleton_method(:"#{name}=") do |value|
          _enums[name] = value
        end

        define_singleton_method(:"#{name}?") do |value|
          send(:"#{name}_value") == value
        end

        define_singleton_method(:"#{name}!") do |value|
          send(:"#{name}=", value)
        end

        define_singleton_method(:"#{name}_values") do
          send(name).values
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
