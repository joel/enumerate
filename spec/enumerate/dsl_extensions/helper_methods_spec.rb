# frozen_string_literal: true

require "enumerate/dsl_extensions/helper_methods"

module Enumerate
  module DslExtensions
    RSpec.describe HelperMethods do
      let(:klass) do
        Class.new do
          extend Enumerate::DslExtensions::HelperMethods::ClassMethods
        end
      end

      describe ".define_helpers_methods" do
        it "defines a instance method" do
          klass.send(:define_helpers_methods, :single)
          expect(klass.new.respond_to?(:single)).to be true
        end
      end
    end
  end
end
