# Bulk check of random urls

require_relative '../lib/theme_bandit'
require 'rubygems'

urls = [
  'http://yootheme.com/demo/themes/joomla/2014/peak/index.php?style=default',
  'http://ign.com',
  'http://gamespot.com',
  'http://news.ycombinator.com',
  'http://reddit.com'
]

def get_root
  Gem::Specification.find_by_name('theme_bandit').gem_dir
rescue Gem::LoadError
  Dir.pwd
end

urls.each do |url|
  ThemeBandit.configure do |config|
    config.url             = url
    config.template_engine = 'erb'
    config.gem_root        = get_root
  end
  document = ThemeBandit::Downloader.get_theme
  ThemeBandit::DocumentWriter.new(document).write
  ThemeBandit::RackGenerator.build
end
