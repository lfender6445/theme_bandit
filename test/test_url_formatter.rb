require_relative 'helper'

describe ThemeBandit::URLFormatter do

  include ThemeBandit::URLFormatter

  it '#strip_query_string' do
    url = 'http://www.example.com?foo=bar'
    assert_equal(strip_query_string(url), 'http://www.example.com')
  end

end
