require_relative '../lib/baidumap/uri_helper'
require 'test/unit'

class TestUriHelper < Test::Unit::TestCase
  def test_construct
    assert_equal('api.map.baidu.com', Baidumap::UriHelper.new('api.map.baidu.com').domain)
  end

  def test_generate_uri
    assert_equal(nil, Baidumap::UriHelper.new('api.map.baidu.com').generate_uri(nil))
  end
end
