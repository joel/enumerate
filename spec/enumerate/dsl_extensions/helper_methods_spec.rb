# frozen_string_literal: true

module Enumerate
  module DslExtensions
    RSpec.describe HelperMethods do
      let(:klass) do
        Class.new do
          extend Enumerate::DslExtensions::HelperMethods::ClassMethods
        end
      end

      describe ".define_helpers_methods" do
        it "defines a class method" do
          klass.send(:define_helpers_methods, :single)
          expect(klass.respond_to?(:single)).to be true
        end

        it "defines a instance method" do
          klass.send(:define_helpers_methods, :single)
          expect(klass.new.respond_to?(:single)).to be true
        end
      end
    end
  end
end
