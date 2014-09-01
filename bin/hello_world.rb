#!/usr/bin/env ruby
require 'fileutils'

# How to steal other people shit with ruby, pt 1

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')

def init
  make_a_directory
end

def make_a_directory
  FileUtils::mkdir_p 'theme'
end

begin
  require 'theme_bandit'
  p 'i know u cant stand it - theme bandit'
  init
rescue LoadError => e
  require 'rubygems'
  require 'theme_bandit'
end

# exit Jeweler::Generator::Application.run!(*ARGV)
