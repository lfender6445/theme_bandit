module ThemeBandit
  module JsParser
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
          src
        else
          "#{url.scheme}://#{url.host}#{src}"
        end
      end
    end
  end
end
