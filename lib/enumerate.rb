# frozen_string_literal: true

require "zeitwerk"
loader = Zeitwerk::Loader.for_gem
loader.ignore("#{__dir__}/dsl_extensions")
loader.ignore("#{__dir__}/behaviours")
loader.setup

module Enumerate
  class Error < StandardError; end
end
