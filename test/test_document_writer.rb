require 'helper'

describe ThemeBandit::DocumentWriter do

  before do
    stub_request_stack
    prep_config
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

  describe '#write' do

    before do
      @subject.write
    end

    describe '#write' do
      it 'writes index.html' do
        assert File.file?("#{Dir.pwd}/theme/public/index.html")
      end
      it 'writes styles' do
        assert File.file?("#{Dir.pwd}/theme/public/css/0_style.css")
      end
      describe 'script writers' do
        # Preserve order of script tags
        it 'orders and renames script 1' do
          assert File.file?("#{Dir.pwd}/theme/public/js/0_script.js")
        end
        it 'orders and renames script 2' do
          assert File.file?("#{Dir.pwd}/theme/public/js/1_script_2.js")
        end
      end
    end

    describe 'parsers/mixin behavior' do
      describe ThemeBandit::CSSParser do
        it '#get_css_files' do
          assert_equal(@subject.get_css_files, ['http://www.example.com/Users/lfender/source/theme_bandit/theme/public/css/0_style.css'])
        end
      end

      describe ThemeBandit::JSParser do
        it '#get_js_files' do
          assert_equal(@subject.get_js_files, ['http://www.example.com/Users/lfender/source/theme_bandit/theme/public/js/0_script.js', 'http://www.example.com/Users/lfender/source/theme_bandit/theme/public/js/1_script_2.js'])
        end
      end
    end
  end

end
