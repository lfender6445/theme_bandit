module ThemeBandit
  module Utils
    def strip_query_string(str)
      str.split('?').first
    end
  end
end
