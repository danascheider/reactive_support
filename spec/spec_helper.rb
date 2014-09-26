require 'simplecov'
require 'coveralls'
require 'rspec'
require 'java' # for JRuby purposes

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start if ENV["COVERAGE"]
Coveralls.wear!

require_relative '../lib/reactive_support'

RSpec.configure do |c|
  c.order  = 'random'
end