require 'test_helper'

class ShadowsTest < Test::Unit::TestCase
  
  should "#require :shadow if there is a file in the load path with exactly the same relative path" do
    assert_nothing_raised do
      assert  require('one')
      assert !require('one')
    end
  end
  
  should "raise LoadError if no :shadow file is found" do
    assert_raise LoadError do
      require('two')
    end
  end
  
  should "raise LoadError if #require :shadow was executed from #eval without specifing a file" do
    assert_raise LoadError do
      require('three')
    end
  end
  
  should "#require :shadow from #eval if file was specified" do
    assert_nothing_raised do
      assert require('four')
    end
  end
  
end
