module ThemeBandit
  class RackGenerator

    def self.build
      new
    end

    def initialize
      copy_template_to_dir("#{Dir.pwd}/theme/")
      generate_view_layout
      generate_view_template
    end

    def copy_template_to_dir(destination, template_dir='application_template')
      t = "#{Dir.pwd}/lib/theme_bandit/generators/#{template_dir}/."
      FileUtils.cp_r t, destination
    end

    def generate_view_layout
    end

    def generate_view_template
    end

  end
end
