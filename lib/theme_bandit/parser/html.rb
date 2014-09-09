module ThemeBandit
  module HTMLParser
    def revise_head_tags
      remove_base_tags
      remove_link_tags
      remove_script_tags
      inject_link_nodes
      inject_script_nodes
    end

    def remove_base_tags
      document.search('base').remove
    end

    def remove_link_tags
      document.search('link').remove
    end

    def remove_script_tags
      document.search('script').remove
    end

    def local_link_names
      path = "#{Dir.pwd}/theme/public/css/"
      Dir.entries(path).map do |file_name|
        "#{path}#{file_name}" if file_name['css']
      end.compact
    end

    def local_script_names
      path = "#{Dir.pwd}/theme/public/js/"
      Dir.entries(path).map do |file_name|
        "#{path}#{file_name}" if file_name['js']
      end.compact.sort
    end

    def link_nodes
      [].tap do |arr|
        local_link_names.each do |link_path|
          link = Nokogiri::XML::Node.new 'link', document
          link.set_attribute('rel', 'stylesheet')
          link.set_attribute('href', "#{link_path}")
          arr << link
        end
      end
    end

    def script_nodes
      [].tap do |arr|
        local_script_names.each do |script_path|
          script = Nokogiri::XML::Node.new 'script', document
          script.set_attribute('src', "#{script_path}")
          arr << script
        end
      end
    end

    def inject_link_nodes
      link_nodes.each do |node|
        document.search('head').first.add_child(node)
      end
    end

    def inject_script_nodes
      script_nodes.each do |node|
        document.search('head').first.add_child(node)
      end
    end
  end
end
