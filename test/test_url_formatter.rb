require_relative 'helper'

describe ThemeBandit::URLFormatter do

  include ThemeBandit::URLFormatter

  it '#strip_query_string' do
    url = 'http://www.example.com?foo=bar'
    assert_equal(strip_query_string(url), 'http://www.example.com')
  end

  it '#resolve_dot_dots' do
    host = 'www.example.com/demo/abc/test.html'
    path = '../doc/docs.css'
    assert_equal(resolve_dot_dots(host, path), 'www.example.com/demo/doc/docs.css')
  end
  it '#cdn_to_fdq' do
    src = '//cdn.optimizely.com/js/2953003.js'
    assert_equal(cdn_to_fdq(src), "http:#{src}")
    src = 'https://cdn.optimizely.com/js/2953003.js'
    assert_equal(cdn_to_fdq(src), src)
  end

end
