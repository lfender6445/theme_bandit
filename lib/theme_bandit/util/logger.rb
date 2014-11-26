module ThemeBandit
  class Logger
    class << self
      attr_accessor :message

      def colorize(text, color_code)
        $stdout.write "\e[#{color_code}m#{text}\e[0m\n"
      end

      def red(text)
        @message = text
        colorize(text, 31)
      end

      def green(text)
        @message = text
        colorize(text, 32)
      end
    end
  end
end
