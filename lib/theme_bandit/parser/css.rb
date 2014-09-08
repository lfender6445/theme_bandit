module ThemeBandit
  module CSSParser
    include ThemeBandit::URLFormatter

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
          strip_query_string href.to_s
        else
          strip_query_string "#{url.scheme}://#{url.host}#{href}"
        end
      end
    end
  end
end
