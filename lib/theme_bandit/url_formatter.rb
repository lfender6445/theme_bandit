module ThemeBandit
  module URLFormatter
    def strip_query_string(str)
      str.split('?').first
    end

    # returns an aboslute url with dot dot syntax removed
    def resolve_dot_dots(host, path)
      number_of_dot_dots = path.split('/').select { |v| v == '..' }.length
      if number_of_dot_dots > 0
        new_path = path.gsub('../', '')
        new_host = host.split('/')
        new_host.pop(number_of_dot_dots + 1)
        new_host.push(new_path).join('/')
      else
        "#{host}#{path}"
      end
    end
  end
end
