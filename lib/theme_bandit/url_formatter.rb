module ThemeBandit
  module URLFormatter
    def strip_query_string(str)
      str.split('?').first
    end

    def cdn_to_fqd(src)
      src[/^\/\//] ? "http:#{src}" : src
    end

    # returns resolved path, ready for use with host
    def get_absolute_path(old_path, new_path)
      number_of_dot_dots = new_path.split('/').select { |v| v == '..' }.length
      if number_of_dot_dots > 0
        # TODO: should be separate method
        new_path = new_path.gsub('../', '')
        old_path = old_path.split('/')
        old_path.pop(number_of_dot_dots + 1)
        old_path.push(new_path).join('/')
      else
        new_path
      end
    end
  end
end
