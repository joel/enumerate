# frozen_string_literal: true

module Enumerate
  RSpec.describe Dsl do
    shared_examples "an enum" do
      describe "._enums" do
        it "defines class attribute" do
          expect(klass).to respond_to(:_enums)
        end

        it "defines values as hashes" do
          expect(klass._enums).to eq(status: { value: 1 }, state: { value: 2, metadata: { foo: "bar" } })
        end
      end

      describe ".define_enum_methods" do
        it "defines enum methods" do
          expect(klass).to respond_to(:status)
        end

        it "returns enum entry value" do
          expect(klass.status).to eq(value: 1)
        end

        it "defines enum getter method for the value" do
          expect(klass.status_value).to eq(1)
        end

        it "defines enum getter method for the values" do
          expect(klass.status_values).to eq([1])
        end

        it "defines enum getter method for the keys" do
          expect(klass.status_keys).to eq([:value])
        end

        it "defines enum predicate method" do
          expect(klass.status?(1)).to eq(true)
        end
      end
    end

    it_behaves_like "an enum" do
      let(:klass) do
        Class.new do
          include Enumerate::Dsl

          enums status: { value: 1 }, state: { value: 2, metadata: { foo: "bar" } }
        end
      end
    end

    it_behaves_like "an enum" do
      let(:klass) do
        Class.new do
          include Enumerate::Dsl

          enums status: 1, state: { value: 2, metadata: { foo: "bar" } }
        end
      end
    end
  end
end
