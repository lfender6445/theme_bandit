require 'helper'

describe ThemeBandit::DocumentWriter do

  def stub_css
    url = 'http://www.example.com/css/style.css'
    stub_request(:get, url).to_return(body: '')
  end

  def stub_js
    url = 'http://www.example.com/js/script.js'
    stub_request(:get, url).to_return(body: '')
    url = 'http://www.example.com/js/script_2.js'
    stub_request(:get, url).to_return(body: '')
  end

  before do
    ThemeBandit.configure { |config| config.template_engine = 'erb' }
    @url = 'http://www.example.com'
    stub_request(:get, @url).to_return(body: load_html_fixture)
    stub_css
    stub_js
    @subject = ThemeBandit::DocumentWriter.new(load_html_fixture, @url)
  end

  after do
    `rm -rf theme`
  end

  describe 'attributes' do
    it 'document' do
      assert_kind_of(Nokogiri::HTML::Document, @subject.document)
    end

    it 'url' do
      assert_kind_of(URI, @subject.url)
    end
  end

  # Mixin Behavior
  describe 'parsers' do
    before do
      @subject.revise_html
    end

    describe ThemeBandit::CSSParser do
      it '#get_css_files' do
        assert_equal(@subject.get_css_files, ["http://www.example.com/Users/lfender/source/theme_bandit/theme/public/css/style.css"])
      end
    end

    describe ThemeBandit::JSParser do
      it '#get_js_files' do
        assert_equal(@subject.get_js_files, ["http://www.example.com/Users/lfender/source/theme_bandit/theme/public/js/0_script.js", "http://www.example.com/Users/lfender/source/theme_bandit/theme/public/js/1_script_2.js"])
      end
    end
  end

  describe '#html_revision' do
    it 'returns revised html' do
      diff(load_html_fixture, @subject.revise_html)
    end
  end

  describe ThemeBandit::RackGenerator do
    # NOTE: For now, document parser is the interface through which RackBuilder is exposed
    # Consider dividing this logic in the future to isolate responsibilities
  end

end
