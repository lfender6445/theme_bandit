require 'httparty'

module ThemeBandit
  class Downloader
    include HTTParty

    def self.get_theme(url=ThemeBandit.configuration.url)
      new(url || error)
    end

    def self.error
      raise 'Invalid configuration, please configure through ./bin wrapper'
    end

    attr_reader :url

    def initialize(url, options = {})
      @url, @options = url, options
      document = get_document
      ThemeBandit::DocumentParser.new document
    end

    def get_document
      doc = self.class.get(url, {})
      Nokogiri::HTML(doc)
    end

  end
end
