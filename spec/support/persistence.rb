# frozen_string_literal: true

require "active_record"
require "with_model"

RSpec.configure do |config|
  config.extend WithModel

  config.before(:each, :sqlite) do
    ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")
  end
end
