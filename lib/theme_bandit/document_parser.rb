module ThemeBandit
  class DocumentParser

    include HTTParty
    include ThemeBandit::CssParser
    include ThemeBandit::JsParser
    include ThemeBandit::HtmlParser
    # TODO: image parser

    attr_accessor :document
    attr_reader   :url

    CSS_FOLDER   =  './theme/public/css/'
    JS_FOLDER    =  './theme/public/js/'
    HTML_FOLDER  =  './theme/public/'


    def initialize(doc)
      @document, @url = doc, URI.parse(ThemeBandit::Downloader.url)
      download_css(get_css_files)
      download_js(get_js_files)
      setup_html
      write_html do
        if true
          ThemeBandit::RackGenerator.build
        end
      end
    end

    def make_dir(folder)
      FileUtils::mkdir_p folder
    end

    def download_css(files)
      make_dir(CSS_FOLDER)
      files.each_with_index do |file_name, count|
        doc = self.class.get(file_name, {})
        new_file = file_name.split('/').last
        File.open("#{CSS_FOLDER}#{new_file}", 'w') { |file| file.write(doc.body) }
      end
    end

    def download_js(files)
      make_dir(JS_FOLDER)
      files.each_with_index do |file_name, order|
        doc = self.class.get(file_name, {})
        new_file = file_name.split('/').last
        File.open("#{JS_FOLDER}#{order}_#{new_file}", 'w') { |file| file.write(doc.body) }
      end
    end

    def html_revision
      document.to_html
    end

    def write_html
      File.open("#{HTML_FOLDER}index.html", 'w') { |file| file.write(html_revision) }
      yield
    end

  end
end
