# frozen_string_literal: true

module Enumerate
  RSpec.describe Dsl do
    shared_examples "an enum" do
      describe ".entries" do
        it "defines class attribute" do
          expect(enum_object).to respond_to(:entries)
        end

        it "defines values as hashes" do
          expect(enum_object.entries).to eq(
            {
              divorced: { value: 3 },
              married: { value: 2 },
              single: { value: 1 },
              widowed: { value: 4 }
            }
          )
        end
      end

      describe ".define_enum_methods" do
        it "defines #single methods" do
          expect(enum_object).to respond_to(:single)
        end

        it "returns enum entry value from the instance" do
          expect(enum_object.single).to eq(1)
        end

        it "defines #translation methods" do
          expect(enum_object).to respond_to(:translation)
        end

        it "returns translation for a given key" do
          expect(enum_object.translation(:single)).to eq("A Person Single")
        end
      end
    end

    it_behaves_like "an enum" do
      let(:enum_object) do
        class RelationshipStatus < Enumerate::Dsl
          enumeration_values single: { value: 1 }, married: { value: 2 }, divorced: { value: 3 }, widowed: { value: 4 }
        end

        RelationshipStatus.new(:relationship_status)
      end
    end

    it_behaves_like "an enum" do
      let(:enum_object) do
        class RelationshipStatus < Enumerate::Dsl
          enumeration_values single: 1, married: 2, divorced: 3, widowed: 4
        end

        RelationshipStatus.new(:relationship_status)
      end
    end

    it_behaves_like "an enum", :focus do
      let(:enum_object) do
        class RelationshipStatus < Enumerate::Dsl
          enumeration_values :single, :married, :divorced, :widowed
        end

        RelationshipStatus.new(:relationship_status)
      end
    end
  end
end
