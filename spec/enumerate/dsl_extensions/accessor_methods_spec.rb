# frozen_string_literal: true

require "enumerate/dsl_extensions/accessor_methods"

module Enumerate
  module DslExtensions
    RSpec.describe AccessorMethods do
      let(:klass) do
        Class.new do
          extend Enumerate::DslExtensions::AccessorMethods::ClassMethods
        end
      end

      subject(:enumeratable) { klass }

      describe ".define_accessor_methods" do
        it "defines a class method" do
          klass.send(:define_accessor_methods, :single)
          expect(klass.respond_to?(:single=)).to be true
        end

        it "defines a instance method" do
          klass.send(:define_accessor_methods, :single)
          expect(klass.new.respond_to?(:single=)).to be true
        end
      end
    end
  end
end
