require_relative 'helper'

describe ThemeBandit::URLFormatter do

  include ThemeBandit::URLFormatter

  it '#strip_query_string' do
    url = 'http://www.example.com?foo=bar'
    assert_equal(strip_query_string(url), 'http://www.example.com')
  end

  describe '#get_absolute_path' do
    it 'it plays nicely with dot dots' do
      host = 'www.example.com/demo/abc/test.html'
      path = '../doc/docs.css'
      assert_equal(get_absolute_path(host, path), 'www.example.com/demo/doc/docs.css')
    end

    describe 'non root-domain themes' do
      before do
        ThemeBandit.configure do |config|
          config.template_engine = 'erb'
          config.url = 'http://yootheme.com/demo/themes/joomla/2014/peak/index.php?style=default'
          config.gem_root = Dir.pwd
        end
      end
      it 'plays nice with non trailing slashes' do
        old_path = '/demo/themes/joomla/2014/peak/index.php'
        new_path = '/demo/themes/joomla/2014/peak/cache/template/widgetkit-627a3380-4ea1c88a.css'
        assert_equal(get_absolute_path(old_path, new_path), '/demo/themes/joomla/2014/peak/cache/template/widgetkit-627a3380-4ea1c88a.css')
      end
    end
  end

  it '#cdn_to_fqd' do
    src = '//cdn.optimizely.com/js/2953003.js'
    assert_equal(cdn_to_fqd(src), "http:#{src}")
    src = 'https://cdn.optimizely.com/js/2953003.js'
    assert_equal(cdn_to_fqd(src), src)
  end

end
