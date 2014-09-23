module ThemeBandit
  class DocumentWriter
    include ThemeBandit::CSSParser
    include ThemeBandit::JSParser
    include ThemeBandit::HTMLParser
    # TODO: image parser
    # TODO: font parser

    attr_accessor :document
    attr_reader :url

    CSS_FOLDER   =  './theme/public/css/'
    JS_FOLDER    =  './theme/public/js/'
    HTML_FOLDER  =  './theme/public/'

    def initialize(doc, url = ThemeBandit.configuration.url)
      @document, @url = Nokogiri::HTML(doc), URI.parse(url)
    end

    def write
      write_html_revision
    end

    private

    def write_html_revision
      make_dir(CSS_FOLDER)
      make_dir(JS_FOLDER)
      download_css(get_css_files)
      download_js(get_js_files)
      revise_head_tags
      write_html_file
    end


    def html
      document.to_html
    end

    def make_dir(folder)
      FileUtils.mkdir_p folder
    end

    def download_css(files, these_are_import_files=false)
      files.each_with_index do |file, order|
        if these_are_import_files
          download_and_replace_import_in_css_file(file, order)
        else
          download_single_css_file(file, order)
        end
      end
    end

    def download_and_replace_import_in_css_file(file, order)
      destination = file[:destination]
      rule = file[:rule]
      doc = Downloader.fetch(destination, {}).body
      new_doc = @doc_with_imports.gsub(rule, doc)
      new_file_name = @file_with_imports.split('/').last
      File.open("#{CSS_FOLDER}#{order}_#{new_file_name}", 'w') { |f| f.write(new_doc) }
      download_css_imports(new_doc, destination) do |imports|
        download_css(imports, true) if imports
      end
    end

    def download_single_css_file(file_name, order)
      doc = Downloader.fetch(file_name, {}).body
      download_css_imports(doc, file_name) do |imports|
        if imports
          download_css(imports, true)
        else
          new_file_name = file_name.split('/').last
          File.open("#{CSS_FOLDER}#{order}_#{new_file_name}", 'w') { |file| file.write(doc) }
        end
      end
    end

    # Use recurison to get to deepest level
    def download_css_imports(doc, file_name)
      if imports = get_import_urls(doc, file_name)
        @doc_with_imports  = doc
        @file_with_imports = file_name
        yield imports
      else
        yield false
      end
    end

    def download_js(files)
      files.each_with_index do |file_name, order|
        doc = Downloader.fetch(file_name, {})
        new_file = file_name.split('/').last
        File.open("#{JS_FOLDER}#{order}_#{new_file}", 'w') { |file| file.write(doc.body) }
      end
    end

    def write_html_file
      File.open("#{HTML_FOLDER}index.html", 'w') { |file| file.write(html) }
    end
  end
end
