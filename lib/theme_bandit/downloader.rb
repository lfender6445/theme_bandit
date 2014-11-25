require 'httparty'

module ThemeBandit
  class Downloader
    include HTTParty

    def self.get_theme(url = ThemeBandit.configuration.url)
      url ? fetch(url) : error
    end

    def self.fetch(url, options = {})
      new(url, options).document
    end

    def self.error
      fail 'Invalid configuration, please configure through ./bin wrapper'
    end

    attr_reader :url, :options, :document

    def initialize(url, options = {})
      @url, @options = url, options
      @document = get_document(url)
    end

    def get_document(url)
      begin
        self.class.get(url, options)
      rescue => e
        p "request failed for #{url} #{e}"
      end
    end
  end
end
