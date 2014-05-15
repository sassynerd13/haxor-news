# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

FactoryGirl.lint # Make sure the default values for all our factories are valid

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include SessionHelpers
  config.order = 'random'
end
