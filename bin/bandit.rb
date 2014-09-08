#!/usr/bin/env ruby

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'fileutils'
require 'theme_bandit'
require 'uri'
require 'bundler'

SUPPORTED_ENGINES = /^(erb|haml|slim|html)$/

def init
  ThemeBandit.configure do |config|
    config.url             = ask_user_for_domain
    config.template_engine = ask_user_for_language
  end
  start_fresh
  document = ThemeBandit::Downloader.get_theme
  generate_app(document)
  ask_user_to_start_rack_app
end

def start_fresh
  `rm -rf theme`
  make_a_directory
end

def generate_app(document)
  ThemeBandit::DocumentWriter.new(document).write
  ThemeBandit::RackGenerator.build
end

def make_a_directory
  FileUtils.mkdir_p 'theme'
end

def ask_user_for_domain
  puts 'Enter the URL of the theme you wish to download (example: http://www.google.com)'
  url = gets.chomp
  if url == ''
    raise 'Invalid url'
  else
    url
  end
end

def ask_user_for_language
  puts 'Enter your templating language (erb, haml, slim)'
  answer = gets.chomp
  fail "We do not support #{answer}" unless match = answer.match(SUPPORTED_ENGINES)
  match[0]
end

def ask_user_to_start_rack_app
  puts 'Do you want to start your new rack app? y/n'
  answer = gets.chomp
  if answer == 'y'
    app_message
    puts 'changing directory to ./theme'
    Dir.chdir 'theme' do
      Bundler.with_clean_env do
        puts "running bundle in #{Dir.pwd}/theme/"
        `bundle install`
        puts 'running `bundle exec rackup -p 3000`'
        system('bundle exec rackup -p 3000')
      end
    end
  else
    app_message
    puts "Don't forget to bundle before starting!"
  end
end

def app_message
  puts "Your rack app can be found at #{Dir.pwd}/theme."
end

begin
  require 'theme_bandit'
  init
rescue LoadError => e
  require 'rubygems'
  require 'theme_bandit'
end
