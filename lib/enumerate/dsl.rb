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
      def enums(*args)
        options = args.extract_options!
        args.each do |name|
          enum(name, options)
        end
      end

      def enum(name, options = {})
        name = name.to_sym
        self._enums = _enums.merge(name => options)
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
          send(name) == value
        end

        define_singleton_method(:"#{name}!") do |value|
          send(:"#{name}=", value)
        end

        define_singleton_method(:"#{name}_values") do
          send(name).values
        end

        define_singleton_method(:"#{name}_keys") do
          send(name).keys
        end
      end
    end
  end
end
