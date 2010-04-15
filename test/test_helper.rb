require 'rubygems'
require 'test/unit'
require 'shoulda'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

$LOAD_PATH.unshift File.expand_path("../fixtures/a", __FILE__)
$LOAD_PATH.unshift File.expand_path("../fixtures/b", __FILE__)

require 'shadows'

class Test::Unit::TestCase
  
end
