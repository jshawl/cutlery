require_relative "../lib/jira"
require_relative "../lib/github"

require 'webmock/rspec'
WebMock.disable_net_connect!

def fixture(name)
  File.read("spec/fixtures/#{name}.json")
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
end
