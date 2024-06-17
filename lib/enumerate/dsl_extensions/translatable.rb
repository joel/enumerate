# frozen_string_literal: true

module Enumerate
  module DslExtensions
    module Translatable
      module InstanceMethods
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
  end
end
