module ThemeBandit
  module CSSParser
    include ThemeBandit::URLFormatter

    RE_IMPORT = /\@import\s*(?:url\s*)?(?:\()?(?:\s*)["']?([^'"\s\)]*)["']?\)?([\w\s\,^\]\(\))]*)\)?[;\n]?/

    def get_css_files
      link_tag_values
    end

    def link_tags
      document.css('link').select do |tag|
        tag.attribute('rel') && tag.attribute('rel').value == 'stylesheet'
      end
    end

    def link_tag_values
      link_tags.map do |tag|
        href = tag.attribute('href').to_s
        href = cdn_to_fqd(href)
        href = URI.parse(href)
        if href.absolute?
          strip_query_string href.to_s
        else
          new_href = strip_query_string(href.to_s)
          absolute_path = get_absolute_path "#{@url.path}", new_href
          absolute = "#{@url.host}#{absolute_path}"
          "#{@url.scheme}://#{absolute}"
        end
      end
    end

    def get_import_urls(file, file_name)
      imports = file.scan(RE_IMPORT).map(&:first).select { |import| import[/\.css/] }
      imports_arr = []
      imports.each do |import|
        dot_dots_length = import.split('/').select { |x| x[/\.\./] }.length
        if dot_dots_length > 0
          file_uri  = URI.parse(file_name)
          matcher   = file_uri.path.split('/').last(dot_dots_length + 1).join('/')
          destination = import.split('/').last(2).join('/')
          dest_file = file_name.gsub(matcher, destination)
          imports_arr << { destination: dest_file, rule: file.match(/\@import.*#{import}(.*\;)?/)[0] }
        else
          file_uri  = URI.parse(file_name)
          matcher   = file_uri.path.split('/').last
          destination = import
          dest_file = file_name.gsub(matcher, destination)
          imports_arr << { destination: dest_file, rule: file.match(/\@import.*#{import}(.*\;)?/)[0] }
        end
      end
      imports_arr.length > 0 ? imports_arr : nil
    end
  end
end
