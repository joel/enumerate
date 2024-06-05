# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Enumerate" do
  let(:enumeration_klass) do
    Class.new do
      include Enumerate::Dsl

      enums :relationship_status

      def self.name
        "RelationshipStatus"
      end
    end
  end

  let(:klass_with_enumeration) do
    Class.new do
      include Enumerate::Base

      has_enumeration_for :relationship_status

      def self.name
        "Person"
      end
    end
  end

  it "stores the enumeration class" do
    expect(klass_with_enumeration.enumerations).to eq(relationship_status: "RelationshipStatus")
  end
end
