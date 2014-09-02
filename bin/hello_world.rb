#!/usr/bin/env ruby
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require 'pry'
require 'fileutils'
require 'theme_bandit'

def init
  make_a_directory
  ask_user_for_domain
  ask_user_for_rack_app
end

def make_a_directory
  FileUtils::mkdir_p 'theme'
end

def ask_user_for_domain
  puts 'Enter the URL of the theme you wish to download:'
  url = gets.chomp
  `rm -rf theme`
  ThemeBandit::Downloader.get_theme(url)
end

def ask_user_for_rack_app
  puts 'Do you want to start your new rack app? y/n'
  answer = gets.chomp
  if answer == 'y'
    app_message
    p 'changing directory to ./theme'
    p 'running `bundle`'
    p 'running `bundle exec rackup -p 3000`'
    `cd theme;bundle;bundle exec rackup -p 3000`
  else
    p app_message
  end
end

def app_message
  p "Your rack app can be found at #{Dir.pwd}/theme"
end

begin
  require 'theme_bandit'
  init
rescue LoadError => e
  require 'rubygems'
  require 'theme_bandit'
end
