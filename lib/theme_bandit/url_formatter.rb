module ThemeBandit
  module URLFormatter
    def strip_query_string(str)
      str.split('?').first
    end
  end
end
