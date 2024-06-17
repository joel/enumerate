# frozen_string_literal: true

class Single; end # rubocop:disable Lint/EmptyClass

module Enumerate
  module Behaviours
    RSpec.describe StoreEnumerationClass do
      let(:receiver) do
        Class.new do
          extend Enumerate::Base
        end
      end
      let(:attribute_name) { :single }
      let(:options) { { with: Single } }

      subject(:helper) do
        described_class.call(receiver, attribute_name, options)
      end

      it "stores the enumeration object" do
        expect { helper }.to change { receiver.enumerations.size }.from(0).to(1)
      end

      it "stores the enumeration object with the correct key" do
        helper
        expect(receiver.enumerations).to have_key(attribute_name)
      end

      it "stores the enumeration object as an instance of the enumeration class" do
        helper
        expect(receiver.enumerations[attribute_name]).to eq(Single)
      end
    end
  end
end
