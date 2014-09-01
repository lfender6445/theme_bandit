module ThemeBandit
  module CssParser
    def get_css_files
      link_tag_values
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
