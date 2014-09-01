#!/usr/bin/env ruby
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require 'fileutils'
require 'theme_bandit'

def init
  make_a_directory
  ask_user_for_domain
end

def make_a_directory
  FileUtils::mkdir_p 'theme'
end

def ask_user_for_domain
  puts 'Enter the URL of the theme you wish to download:'
  url = gets.chomp
  ThemeBandit::Downloader.get_theme(url)
end

begin
  require 'theme_bandit'
  init
rescue LoadError => e
  require 'rubygems'
  require 'theme_bandit'
end

# exit Jeweler::Generator::Application.run!(*ARGV)
