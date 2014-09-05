require 'uri'
require 'nokogiri'

require_relative 'downloader'
require_relative 'url_formatter'

require_relative 'parser/css'
require_relative 'parser/js'
require_relative 'parser/html'

# must come after all other parsers
require_relative 'document_parser'

require_relative 'generators/rack_generator'

require_relative 'util/configure'
require_relative 'util/version'
