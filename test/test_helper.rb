require 'simplecov'

if ENV['CODECOV_TOKEN']
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

SimpleCov.start do
  root File.expand_path(File.dirname(__FILE__) + '/..')
  add_filter "/test/"
end

require File.expand_path(File.dirname(__FILE__) + '/../../../test/test_helper')

# Ensure that we are using the temporary fixture path
#Engines::Testing.set_fixture_path
