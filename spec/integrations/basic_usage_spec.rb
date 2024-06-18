# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Enumerate" do
  subject(:instance) { klass_with_enumeration.new }

  let!(:enumeration_class) do
    class RelationshipStatus < Enumerate::Dsl
      enumeration_values single: { value: 1 }, married: { value: 2 }, divorced: { value: 3 }, widowed: { value: 4 }
    end

    RelationshipStatus
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

  context "with accessors" do
    it "defines a class method" do
      expect(enumeration_class.single).to eq(1)
    end

    it "defines a instance method" do
      expect(enumeration_class).to respond_to(:single=)
    end
  end
end
