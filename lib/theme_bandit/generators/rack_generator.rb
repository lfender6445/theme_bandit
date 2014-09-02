require 'html2slim/command'
require 'sanitize'

module ThemeBandit
  class RackGenerator

    def self.build
      new
    end

    def initialize
      copy_template_to_dir("#{Dir.pwd}/theme/")
      generate_view
    end

    def copy_template_to_dir(destination, template_dir='application_template')
      t = "#{Dir.pwd}/lib/theme_bandit/generators/#{template_dir}/."
      FileUtils.cp_r t, destination
    end

    def index_file_contents
      file = File.open("#{Dir.pwd}/theme/public/index.html",'r')
      html_content = File.read(file)
      html = Sanitize.document(html_content, Sanitize::Config::RELAXED)#
      absolute_to_relative(html)
    end

    def absolute_to_relative(contents)
      contents.gsub("#{Dir.pwd}/theme/public", '')
    end

    def generate_view
      slim_contents = HTML2Slim.convert!(index_file_contents, :html)
      File.open("#{Dir.pwd}/theme/app/views/templates/index.slim", 'w') { |file| file.write(slim_contents) }
    end

  end
end
