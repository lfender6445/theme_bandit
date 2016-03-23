require_relative 'helper'

describe ThemeBandit::DocumentWriter do

  before do
    prep_config
    stub_request_stack
    @subject = ThemeBandit::DocumentWriter.new(load_html_fixture, test_url)
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

      it 'preserves inline scripts' do
        assert @subject.document.search('script')[2]
      end

      describe 'import output' do
        it 'merges css files' do
          contents = File.read(File.open("#{Dir.pwd}/theme/public/css/0_style_with_import.css", 'r'))
          expected = "h1 {color:blue;}\n\nbody {color:red}\n"
          assert_equal contents, expected
        end
      end

    end

    describe 'parser mixin behavior' do

      describe ThemeBandit::CSSParser do
        it '#get_css_files' do
          assert_equal(@subject.get_css_files, ["http://www.example.com#{Dir.pwd}/theme/public/css/0_style.css", "http://www.example.com#{Dir.pwd}/theme/public/css/0_style_with_import.css"])
        end

        describe '#get_import_urls' do
          it 'returns false if none found' do
            assert_equal(@subject.get_import_urls(load_css_fixture, 'import.css'), nil)
          end
          it 'returns import urls' do
            expected = [{ destination: 'import.css', rule: "@import url('import.css');" }]
            assert_equal(@subject.get_import_urls(load_style_with_import_fixture, 'style_with_import.css'), expected)
          end
        end
      end

      describe ThemeBandit::JSParser do
        it '#get_js_files' do
          assert_equal(@subject.get_js_files, ["http://www.example.com#{Dir.pwd}/theme/public/js/0_script.js", "http://www.example.com#{Dir.pwd}/theme/public/js/1_script_2.js"])
        end
      end
    end
  end

end
