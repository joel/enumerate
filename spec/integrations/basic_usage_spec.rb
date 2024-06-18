# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Enumerate" do
  let!(:enumeration_class) do
    class RelationshipStatus < Enumerate::Dsl
      enums single: { value: 1 }, married: { value: 2 }, divorced: { value: 3 }, widowed: { value: 4 }
    end
  end

  let(:klass_with_enumeration) do
    Class.new do
      extend Enumerate::Behaviour

      has_enumeration_for :relationship_status

      def self.name
        "Person"
      end
    end
  end

  it "stores the enumeration object" do
    expect(klass_with_enumeration.enumerations.size).to eq(1)
  end

  it "stores the enumeration object with the correct key" do
    expect(klass_with_enumeration.enumerations).to have_key(:relationship_status)
  end

  it "stores the enumeration object as an instance of the enumeration class" do
    expect(klass_with_enumeration.enumerations[:relationship_status]).to eq(RelationshipStatus)
  end
end
