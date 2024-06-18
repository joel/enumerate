# frozen_string_literal: true

require "i18n"

I18n.config.enforce_available_locales = false
I18n.load_path = Dir["spec/i18n/*.yml"]
