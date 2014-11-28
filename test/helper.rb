ENV['RACK_ENV'] = 'test'

require 'pry'

require 'rubygems'
require 'minitest/autorun'
require 'webmock/minitest'

require_relative '../lib/theme_bandit'

require_relative 'support/common'

MiniTest.autorun

# supress log output when running tests
module ThemeBandit
  class Log
    class << self
      def colorize(_text, _color_code)
      end
    end
  end
end

