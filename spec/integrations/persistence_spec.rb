# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Persistence", :sqlite do
  subject(:model) { Person.new(attributes) }

  let!(:enumeration_klass) do
    class RelationshipStatus < Enumerate::Dsl
      enums single: { value: 1 }, married: { value: 2 }, divorced: { value: 3 }, widowed: { value: 4 }
    end
  end

  context "with a model" do
    with_model :Person do
      table do |t|
        t.string :relationship_status
      end

      model do
        extend Enumerate::Base

        has_enumeration_for :relationship_status
      end
    end

    context "with a nil value" do
      let(:attributes) { { relationship_status: :single } }

      it "stores the value" do
        expect do
          model.save!
        end.to change(Person, :count).by(1)
      end

      it "retrieves the value" do
        model.save!

        expect(Person.last.relationship_status).to eq("single")
      end
    end
  end
end
