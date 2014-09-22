require 'rubygems'
require 'pry'
require 'minitest/autorun'
require 'webmock/minitest'

require_relative '../lib/theme_bandit'

MiniTest.autorun

def load_html_fixture
  @fixture ||= File.read(File.open("#{Dir.pwd}/test/fixtures/index.html", 'r'))
end

def test_url
  'http://www.example.com'
end

def stub_request_stack
  stub_request(:any, test_url).to_return(body: load_html_fixture)
  stub_css
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
  stub_request(:any, url).to_return(body: 'hello')
end

def stub_js
  url = 'http://www.example.com/js/script.js'
  stub_request(:any, url).to_return(body: '')
  url = 'http://www.example.com/js/script_2.js'
  stub_request(:any, url).to_return(body: '')
end
