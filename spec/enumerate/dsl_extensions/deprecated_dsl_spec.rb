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

      describe ".associate_values" do
        before do
          allow(enumeratable).to receive(:enumeration_values)
        end

        it "emits a deprecation warning" do
          expect do
            enumeratable.associate_values(:status, { active: 1, inactive: 0 })
          end.to have_deprecated_warning("`associate_values` is deprecated and will be removed in a future release. Please use `enumeration_values` instead.")
        end
      end
    end
  end
end
