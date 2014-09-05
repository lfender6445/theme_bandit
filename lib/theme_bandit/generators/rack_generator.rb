require 'html2slim/command'

# TODO: Move generators/recipes to top level and rack generator up

module ThemeBandit
  class RackGenerator

    def self.build
      new
    end

    TEMPLATE_ERROR = 'Templating engine not supported'

    def initialize
      copy_template_to_dir("#{Dir.pwd}/theme/")
      generate_view
    end

    # NOTE: to copy the innards of a dir, use a /.
    # example - recipes/sinatra/.
    def copy_template_to_dir(destination, template_dir='recipes/sinatra/.')
      t = "#{Dir.pwd}/lib/theme_bandit/generators/#{template_dir}"
      FileUtils.cp_r t, destination
    end

    def index_file_contents
      index_html = File.open("#{Dir.pwd}/theme/public/index.html",'r')
      absolute_to_relative(File.read(index_html))
    end

    # Convert all links in html document to relative for ruby app
    def absolute_to_relative(contents)
      contents.gsub("#{Dir.pwd}/theme/public", '')
    end

    def generate_view
      case ThemeBandit.configuration.template_engine
      when 'slim'
        slim_contents = HTML2Slim.convert!(index_file_contents, :html)
        File.open("#{Dir.pwd}/theme/app/views/templates/index.slim", 'w') { |file| file.write(slim_contents) }
      else
        raise TEMPLATE_ERROR
      end
    end

  end
end
