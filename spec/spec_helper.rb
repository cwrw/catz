require 'capybara/rspec'
require 'webmock/rspec'
require 'nokogiri'
require 'open-uri'
require 'catz'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.disable_monkey_patching!
  config.warnings = true
  config.order = :random

  config.default_formatter = 'doc' if config.files_to_run.one?
  Kernel.srand config.seed
end
