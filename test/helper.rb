require 'rubygems'
require 'pry'
require 'minitest/autorun'
require 'webmock/minitest'

require_relative '../lib/theme_bandit'

MiniTest.autorun

def load_html_fixture
  @fixture||=File.read(File.open("#{Dir.pwd}/test/fixtures/index.html",'r'))
end
