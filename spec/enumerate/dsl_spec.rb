# frozen_string_literal: true

module Enumerate
  RSpec.describe Dsl do
    let(:klass) do
      Class.new do
        include Enumerate::Dsl

        enums :status, :state
      end
    end

    describe ".enums" do
      it "defines enum methods" do
        expect(klass).to respond_to(:status)
        expect(klass).to respond_to(:status?)
        expect(klass).to respond_to(:status!)
        expect(klass).to respond_to(:status=)
        expect(klass).to respond_to(:status_values)
        expect(klass).to respond_to(:status_keys)

        expect(klass).to respond_to(:state)
        expect(klass).to respond_to(:state?)
        expect(klass).to respond_to(:state!)
        expect(klass).to respond_to(:state=)
        expect(klass).to respond_to(:state_values)
        expect(klass).to respond_to(:state_keys)

        expect(klass._enums).to eq(status: {}, state: {})

        klass.enum(:status, active: 1, inactive: 0)
        klass.enum(:state, active: 1, inactive: 0)

        expect(klass.status).to eq(active: 1, inactive: 0)
        expect(klass.state).to eq(active: 1, inactive: 0)

        expect(klass.status_values).to eq([1, 0])
        expect(klass.state_values).to eq([1, 0])

        expect(klass.status_keys).to eq(%i[active inactive])
        expect(klass.state_keys).to eq(%i[active inactive])

        expect(klass.status?({ active: 1, inactive: 0 })).to be(true)
        expect(klass.state?({ active: 1, inactive: 0 })).to be(true)
      end
    end
  end
end
