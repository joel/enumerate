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
              divorced: { value: 7 },
              married:  { value: 6 },
              single:   { value: 5 },
              widowed:  { value: 8 }
            }
          )
        end
      end

      # describe ".define_enum_methods" do
      #   it "defines enum methods" do
      #     expect(enum_object).to respond_to(:status)
      #   end

      #   it "returns enum entry value" do
      #     expect(enum_object.status).to eq(value: 1)
      #   end

      #   it "defines enum getter method for the value" do
      #     expect(enum_object.status_value).to eq(1)
      #   end

      #   it "defines enum getter method for the keys" do
      #     expect(enum_object.status_keys).to eq([:value])
      #   end
      # end
    end

    # it_behaves_like "an enum" do
    #   let(:enum_object) do
    #     class RelationshipStatus
    #       include Enumerate::Dsl

    #       enums :single, :married, :divorced, :widowed
    #     end

    #     RelationshipStatus.new(:relationship_status)
    #   end
    # end

    it_behaves_like "an enum" do
      let(:enum_object) do
        class RelationshipStatus
          include Enumerate::Dsl

          enums single: 1, married: 2, divorced: 3, widowed: 4
        end

        RelationshipStatus.new(:relationship_status)
      end
    end

    # it_behaves_like "an enum" do
    #   let(:enum_object) do
    #     class RelationshipStatus
    #       include Enumerate::Dsl

    #       enums single: { value: 1 }, married: { value: 2 }, divorced: { value: 3 }, widowed: { value: 4 }
    #     end.new(:relationship_status)
    #   end
    # end
  end
end
