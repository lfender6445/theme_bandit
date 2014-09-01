require 'httparty'
require 'pry'
module ThemeBandit
  class Downloader
    include HTTParty

    attr_reader :url

    class << self
      attr_reader :url
    end

    def self.get_theme(url)
      @url = url
      new url
    end

    def initialize(url, options = {})
      @url, @options = url, options
      document = get_document
      ThemeBandit::DocumentParser.new document
    end

    def get_document
      doc = self.class.get(url, {})
      Nokogiri::HTML(doc)
    end

    def make_a_dir(folder_name)
      FileUtils::mkdir_p folder_name
    end

    def download_css
      make_a_dir('css')
    end

  end
end
