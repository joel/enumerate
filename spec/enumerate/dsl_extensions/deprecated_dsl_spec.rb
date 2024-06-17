# frozen_string_literal: true

require "enumerate/dsl_extensions/deprecation"

module Enumerate
  module DslExtensions
    RSpec.describe Deprecation do
      let(:klass) do
        Class.new do
          extend Enumerate::DslExtensions::Deprecation::ClassMethods
        end
      end

      subject(:enumeratable) { klass }

      describe ".enumeration_value" do
        before do
          expect(enumeratable).to receive(:enum).with(:status, { active: 1, inactive: 0 })
        end

        it "emits a deprecation warning" do
          expect do
            enumeratable.enumeration_value(:status, { active: 1, inactive: 0 })
          end.to have_deprecated_warning("`enumeration_value` is deprecated and will be removed in a future release. Please use `enum` instead.")
        end
      end
    end
  end
end
