require_relative '../lib/mumukit/inspection'
require 'mumukit/core/rspec'

require "codeclimate-test-reporter"
SimpleCov.start

def expectation(binding, inspection)
  Mulang::Expectation.parse(binding: binding, inspection: inspection)
end
