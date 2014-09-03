$LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)

require 'simplecov'
require 'coveralls'
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start do
  coverage_dir('coverage/')
end

require 'rspec/core'
require 'vagrant-adam'

RSpec.configure do |config|
  config.formatter = :documentation

  # a little syntactic sugar
  config.alias_it_should_behave_like_to :it_has_behavior, 'has behavior:'

  # Use color in STDOUT
  config.color = true

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  # run the examples in random order
  config.order = :rand

  # specify metadata with symobls only (ie no '=> true' required)
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
end

# @return [String] the path to the fixture file
def support_path(filename)
  File.expand_path("../../support/#{filename}", __FILE__)
end
