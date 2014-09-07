#!/usr/bin/env ruby_executable_hooks

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'pry'
require 'fileutils'
require 'theme_bandit'

SUPPORTED_ENGINES = /^(erb|haml|slim|html)$/

def init
  ThemeBandit.configure do |config|
    config.url             = ask_user_for_domain
    config.template_engine = ask_user_for_language
  end
  start_fresh
  ThemeBandit::Downloader.get_theme
  ask_user_to_start_rack_app
end

def start_fresh
  `rm -rf theme`
  make_a_directory
end

def make_a_directory
  FileUtils::mkdir_p 'theme'
end

def ask_user_for_domain
  # puts 'Enter the URL of the theme you wish to download:'
  # gets.chomp
  'https://www.google.com/'
end

def ask_user_for_language
  puts 'Enter your templating language (erb, haml, slim)'
  answer = gets.chomp
  raise "We do not support #{answer}" unless match = answer.match(SUPPORTED_ENGINES)
  match[0]
end

def ask_user_to_start_rack_app
  puts 'Do you want to start your new rack app? y/n'
  answer = gets.chomp
  if answer == 'y'
    app_message
    puts 'changing directory to ./theme'
    Dir.chdir 'theme'
    puts 'running `bundle in new directory`'
    Bundler.with_clean_env do
      `bundle install`
    end
    puts 'bundle exec rackup -p 3000`'
    system('bundle exec rackup -p 3000')
  else
    app_message
  end
end

def app_message
  puts "Your rack app can be found at #{Dir.pwd}/theme."
  puts "Don't forget to bundle before starting!"
end

begin
  require 'theme_bandit'
  init
rescue LoadError => e
  require 'rubygems'
  require 'theme_bandit'
end
