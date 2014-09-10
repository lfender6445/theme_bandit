require 'pry'
require 'css_parser'

module ThemeBandit
  # Consider Renaming?
  module CSSParser
    include CssParser

    include ThemeBandit::URLFormatter

    RE_IMPORT = /\@import\s*(?:url\s*)?(?:\()?(?:\s*)["']?([^'"\s\)]*)["']?\)?([\w\s\,^\]\(\))]*)\)?[;\n]?/

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

    def get_import_urls(file, file_name)
      # collect list of resolvable import urls
      # remove import rules in files
      # recursively download_css imports if there has been a collection
      # "http://livedemo00.template-help.com/wordpress_51146/wp-content/themes/theme51146/main-style.css"
      # http://livedemo00.template-help.com/wordpress_51146/wp-content/themes/CherryFramework/style.css
      imports = file.scan(RE_IMPORT).map { |import| import.first }.select {|import| import[/\.css/] }
      imports_arr = []
      imports.each do |import|
        dot_dots_length = import.split('/').select { |x| x[/\.\./] }.length
        if dot_dots_length > 0
          file_uri  = URI.parse(file_name)
          matcher   = file_uri.path.split('/').last(dot_dots_length + 1).join('/')
          destination = import.split('/').last(2).join('/')
          dest_file = file_name.gsub(matcher, destination)
          imports_arr << dest_file
        else
          file_uri  = URI.parse(file_name)
          matcher   = file_uri.path.split('/').last
          destination = import
          dest_file = file_name.gsub(matcher, destination)
          imports_arr << dest_file
        end
      end
      imports_arr.length > 0 ? imports_arr : nil
    end

  end
end
