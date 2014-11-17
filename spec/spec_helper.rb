require 'simplecov'
require 'coveralls'
require 'rspec'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start if ENV["COVERAGE"]
Coveralls.wear!

require File.expand_path('../../lib/reactive_support.rb', __FILE__)

RSpec.configure do |c|
  c.order  = 'random'
end