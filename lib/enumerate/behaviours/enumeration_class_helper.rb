# frozen_string_literal: true

require "active_support/inflector"

module Enumerate
  module Behaviours
    class EnumerationClassHelper
      class << self
        def call(_receiver, attribute_name, options)
          return if options[:with]

          options[:with] = attribute_name.to_s.classify.constantize
        end
      end
    end
  end
end
