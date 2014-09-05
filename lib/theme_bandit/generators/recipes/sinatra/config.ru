require 'rubygems'

def env
  (ENV['RACK_ENV'] || 'development').to_sym
end

gemfile = File.expand_path('../../Gemfile', __FILE__)

ROOT = Dir.pwd

begin
  ENV['BUNDLE_GEMFILE'] = gemfile
  require 'bundler'
  Bundler.setup
rescue Bundler::GemNotFound => e
  STDERR.puts e.message
  STDERR.puts 'Try running `bundle install`.'
  exit!
end if File.exist?(gemfile)

Bundler.require(:default, env)

require File.join(File.dirname(__FILE__),'app','application.rb')

run Application
