# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in enumerate.gemspec
gemspec

gem "i18n"
gem "rake"

group :development, :test do
  gem "rubocop"
  gem "rubocop-gitlab-security"
  gem "rubocop-i18n"
  gem "rubocop-performance"
  gem "rubocop-rake"
  gem "rubocop-rspec"
  gem "rubocop-thread_safety"
end

group :test do
  gem "rspec"
  gem "sqlite3", "~> 1.7"
  gem "with_model"
end
