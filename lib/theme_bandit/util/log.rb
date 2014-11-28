require 'logger'
module ThemeBandit
  class Log < Logger
    class << self
      attr_accessor :message

      def colorize(text, color_code)
        $stdout.write "\e[#{color_code}m#{text}\e[0m\n"
      end

      def red(text)
        @message = text
        colorize(text, 31)
        logger.error text
      end

      def patch(old_file_name, new_file_name)
        @message = "#{old_file_name} failed to download. Manually patch .theme/public/*/#{new_file_name} in its place"
        logger.error @message
      end

      def yellow(text)
        @message = text
        colorize(text, 33)
      end

      def green(text)
        @message = text
        colorize(text, 32)
      end

      private

      def logger
        @logger ||= new 'error.log'
      end

    end
  end
end
