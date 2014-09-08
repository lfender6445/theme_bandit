module ThemeBandit
  module JSParser
    include ThemeBandit::URLFormatter

    def get_js_files
      script_tag_values
    end

    def script_tags
      document.css('script').select do |tag|
        tag.attribute('src')
      end
    end

    def script_tag_values
      script_tags.map do |tag|
        src = URI.parse(tag.attribute('src'))
        if src.absolute?
          strip_query_string src.to_s
        else
          strip_query_string "#{url.scheme}://#{url.host}#{src}"
        end
      end
    end
  end
end
