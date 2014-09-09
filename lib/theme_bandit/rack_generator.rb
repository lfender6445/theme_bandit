require 'html2slim/command'

require 'html2haml'

module ThemeBandit
  class RackGenerator
    def self.build
      new
    end

    THEME_DIR = "#{Dir.pwd}/theme/"
    TEMPLATE_ERROR = 'Templating engine not supported'

    def initialize
      copy_template_to_dir(THEME_DIR)
      generate_view
    end

    def get_recipe(root = ThemeBandit.configuration.gem_root)
      src = "#{root}/lib/theme_bandit/recipes/sinatra/#{ThemeBandit.configuration.template_engine}/"
      Dir.glob("#{src}/**/*")
    end

    # NOTE: to copy the innards of a dir, use a /., with a dot at the end
    # example - recipes/sinatra/.
    def copy_template_to_dir(destination)
      t = get_recipe
      FileUtils.cp_r t, destination
    end

    def index_file_contents
      index_html = File.open("#{Dir.pwd}/theme/public/index.html", 'r')
      absolute_to_relative(File.read(index_html))
    end


    def absolute_to_relative(contents)
      contents.gsub("#{Dir.pwd}/theme/public", '')
    end

    def generate_view(root = Dir.pwd)
      case ThemeBandit.configuration.template_engine
      when 'slim'
        slim_contents = HTML2Slim.convert!(index_file_contents, :html)
        File.open("#{root}/theme/app/views/templates/index.slim", 'w') { |file| file.write(slim_contents) }
      when ('erb' || 'html')
        File.open("#{root}/theme/app/views/templates/index.erb", 'w') { |file| file.write(index_file_contents) }
      when 'haml'
        haml_contents = Haml::HTML.new(index_file_contents, erb: nil).render
        File.open("#{root}/theme/app/views/templates/index.haml", 'w') { |file| file.write(haml_contents) }
      else
        fail TEMPLATE_ERROR
      end
    end
  end
end
