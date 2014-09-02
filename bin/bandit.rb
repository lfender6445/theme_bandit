#!/usr/bin/env ruby_executable_hooks

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'pry'
require 'fileutils'
require 'theme_bandit'

def init
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
  make_a_directory
  ThemeBandit::Downloader.get_theme(url)
end

def ask_user_for_rack_app
  puts 'Do you want to start your new rack app? y/n'
  answer = gets.chomp
  if answer == 'y'
    app_message
    puts 'changing directory to ./theme'
    Dir.chdir 'theme'
    puts 'running `bundle in new directory`'
    Bundler.with_clean_env do
      `bundle install`
      puts 'bundle exec rackup -p 3000`'
      system('bundle exec rackup -p 3000')
    end
  else
    app_message
  end
end

def app_message
  puts "Your rack apputs can be found at #{Dir.pwd}/theme"
end

begin
  require 'theme_bandit'
  init
rescue LoadError => e
  require 'rubygems'
  require 'theme_bandit'
end
