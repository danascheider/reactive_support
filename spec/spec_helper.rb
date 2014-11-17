require 'simplecov'
require 'coveralls'
require 'rspec'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start if ENV["COVERAGE"]
Coveralls.wear!

# ReactiveExtensions requires ReactiveSupport, but not vice versa
require File.expand_path('../../lib/extensions/reactive_extensions', __FILE__)

RSpec.configure do |c|
  c.order  = 'random'
end