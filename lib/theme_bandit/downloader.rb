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
      Logger.red 'Invalid configuration, please configure through ./bin wrapper'
    end

    attr_reader :url, :options, :document

    def initialize(url, options = {})
      @url, @options = url, options
      @document = get_document(url)
    end

    def get_document(url)
      Logger.green "Downloading #{url}"
      self.class.get(url, options)
    rescue => e
      Logger.red "request failed for #{url} #{e}"
    end
  end
end
