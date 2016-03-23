def load_html_fixture
  # @fixture ||= File.read(File.open("#{Dir.pwd}/test/fixtures/index.html", 'r'))

  @fixture ||= File.read(File.expand_path("../../fixtures/index.html", __FILE__))
end

def load_css_fixture
  File.read(File.open("#{Dir.pwd}/test/fixtures/css/style.css", 'r'))
end

def load_import_fixture
  File.read(File.open("#{Dir.pwd}/test/fixtures/css/import.css", 'r'))
end

def load_style_with_import_fixture
  File.read(File.open("#{Dir.pwd}/test/fixtures/css/style_with_import.css", 'r'))
end

def test_url
  'http://www.example.com'
end

def stub_request_stack
  stub_request(:any, test_url).to_return(body: load_html_fixture)
  stub_css
  stub_import_css
  stub_style_with_import_css
  stub_js
end

def prep_config
  ThemeBandit.configure do |config|
    config.template_engine = 'erb'
    config.url = test_url
    config.gem_root = Dir.pwd
  end
end

def stub_css
  url = 'http://www.example.com/css/style.css'
  stub_request(:any, url).to_return(body: load_css_fixture)
end

def stub_import_css
  url = 'http://www.example.com/css/import.css'
  stub_request(:any, url).to_return(body: load_import_fixture)
end

def stub_style_with_import_css
  url = 'http://www.example.com/css/style_with_import.css'
  stub_request(:any, url).to_return(body: load_style_with_import_fixture)
end

def stub_js
  url = 'http://www.example.com/js/script.js'
  stub_request(:any, url).to_return(body: '')
  url = 'http://www.example.com/js/script_2.js'
  stub_request(:any, url).to_return(body: '')
end

