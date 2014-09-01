require 'nokogiri'
require 'uri'

module ThemeBandit
  class DocumentParser

    attr_reader :document, :url

    def initialize(doc)
      @document, @url = doc, URI.parse(ThemeBandit::Downloader.url)
      get_css_files
    end

    def get_css_files
      p link_tag_values
      binding.pry
    end

    def link_tags
      document.css('link').select do |tag|
        tag.attribute('rel').value == 'stylesheet'
      end
    end

    def link_tag_values
      link_tags.map do |tag|
        href = URI.parse(tag.attribute('href'))
        if href.absolute?
          href
        else
          "#{url.scheme}://#{url.host}#{href}"
        end
      end
    end

  end
end
