require 'uri'

module ThemeBandit
  class DocumentParser

    include ThemeBandit::CssParser
    include HTTParty

    attr_reader :document, :url

    def initialize(doc)
      @document, @url = doc, URI.parse(ThemeBandit::Downloader.url)
      download_and_write_css(get_css_files)
    end

    def download_and_write_css(files)
      download(files)
    end

    def make_dir(folder)
      FileUtils::mkdir_p "theme/#{folder}"
    end

    # return array of string/css docs
    def download(files)
      make_dir('css')
      count = 0
      files.each do |file_name|
        doc = self.class.get(file_name, {})
        File.open("./theme/css/style_#{count}.css", 'w') { |file| file.write(doc) }
        count += 1
      end
    end

  end
end
