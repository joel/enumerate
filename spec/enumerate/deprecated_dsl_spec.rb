# frozen_string_literal: true

module Enumerate
  RSpec.describe DeprecatedDsl do
    let(:klass) do
      Class.new do
        include Enumerate::Dsl
        include Enumerate::DeprecatedDsl
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
