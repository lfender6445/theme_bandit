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
        src = cdn_to_fdq(src)
        src = URI.parse(src)
        if src.absolute?
          strip_query_string src.to_s
        else
          new_src = strip_query_string(src.to_s)
          absolute = resolve_dot_dots "#{@url.host}#{@url.path}", new_src
          "#{url.scheme}://#{absolute}"
        end
      end
    end
  end
end
