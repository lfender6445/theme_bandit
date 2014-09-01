require 'httparty'
module ThemeBandit
  class Downloader

    def initialize(url)
      @url = url
      p "The url is #{url}"
    end
  end
end
