require 'simplecov'
require 'vcr'
require 'webmock/rspec'

RSpec.configure do |config|
  config.order = :random
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
end

SimpleCov.start 'rails'
