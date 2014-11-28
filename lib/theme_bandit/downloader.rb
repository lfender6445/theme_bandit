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
      Log.red 'Invalid configuration, please configure through ./bin wrapper or ThemeBandit::Configure'
    end

    attr_reader :url, :options, :document, :error

    def initialize(url, options = {})
      @url, @options = default_to_http(url), options
      @document = get_document(url)
    end

    def get_document(url)
      response = self.class.get(url, options)
      log_request(url, response)
      response
    rescue => e
      Log.red "request failed for #{url} #{e}"
      false
    end

    private

    def log_request(url, response)
      if response.code != 200
        @error = response.code
        Log.red   "Request failure trying to download #{url}, status #{response.code}"
      else
        Log.green "Downloading #{url}"
      end
    end

    def default_to_http(url)
      url[/(^http:\/\/|^https:\/\/)/] ? url : "http://#{url}"
    end
  end
end
