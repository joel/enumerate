# frozen_string_literal: true

require "enumerate/behaviours/virtual_accessors"

class Single; end # rubocop:disable Lint/EmptyClass

module Enumerate
  module Behaviours
    RSpec.describe VirtualAccessors do
      let(:receiver) do
        Class.new do
          extend Enumerate::Behaviour

          attr_accessor :status
        end
      end
      let(:instance) { receiver.new }
      let(:attribute_name) { :relationship_status }
      let(:options) { { column: :status } }

      before do
        described_class.call(receiver, attribute_name, options)
      end

      it "creates a getter method for the attribute" do
        expect(instance).to respond_to(:relationship_status)
      end

      it "creates a setter method for the attribute" do
        expect(instance).to respond_to(:relationship_status=)
      end

      it "sets the attribute value when the setter method is called" do
        expect { instance.relationship_status = (:foo) }.to change(instance, :status).from(nil).to(:foo)
      end

      context "when the column option is not provided" do
        before do
          instance.relationship_status = (:foo)
        end

        it "returns the value of the column" do
          expect(instance.relationship_status).to eq(:foo)
        end
      end
    end
  end
end
