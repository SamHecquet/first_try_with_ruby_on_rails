ENV['RAILS_ENV'] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'shoulda/matchers'

RSpec.configure do |config|
  config.include Shoulda::Matchers::ActiveModel, type: :model
  config.include Shoulda::Matchers::ActiveRecord, type: :model
  config.include ApplicationHelper
  
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  
  config.infer_spec_type_from_file_location!
  config.raise_errors_for_deprecations!
  config.filter_rails_from_backtrace!
  
  
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
    expectations.syntax = :expect
  end

  config.mock_with :rspec
  
  config.include FactoryGirl::Syntax::Methods
end

ActiveRecord::Migration.maintain_test_schema!