begin
  require 'simplecov'
  SimpleCov.start do
    root File.expand_path(File.dirname(__FILE__) + '/..')
    add_filter '/test/'
  end
rescue LoadError
end

require File.expand_path(File.dirname(__FILE__) + '/../../../test/test_helper')
