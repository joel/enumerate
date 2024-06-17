# frozen_string_literal: true

class Single; end # rubocop:disable Lint/EmptyClass

module Enumerate
  module Behaviours
    RSpec.describe EnumerationClassHelper do
      let(:receiver) { nil }
      let(:attribute_name) { :single }
      let(:options) { {} }

      subject(:helper) do
        described_class.call(receiver, attribute_name, options)
      end

      context "when options[:with] is not present" do
        it "sets options[:with] to the class of the attribute_name" do
          expect { helper }.to change { options[:with] }.from(nil).to(Single)
        end
      end
    end
  end
end
