# frozen_string_literal: true

module Enumerate
  module Behaviours
    class EnumerationClassHelper
      class << self
        def call(_receiver, attribute_name, options)
          return if options[:with]

          options[:with] = attribute_name.to_s.camelize.constantize
        end
      end
    end
  end
end
