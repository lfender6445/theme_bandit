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
        src = tag.attribute('src').to_s
        src = cdn_to_fqd(src)
        src = URI.parse(src)
        if src.absolute?
          strip_query_string src.to_s
        else
          new_src = strip_query_string(src.to_s)
          absolute_path = get_absolute_path "#{@url.path}", new_src
          absolute = "#{@url.host}#{absolute_path}"
          "#{url.scheme}://#{absolute}"
        end
      end
    end
  end
end
