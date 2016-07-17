module Rbi3status
  module Command
    class DateTime < Base
      def initialize(options = {})
        super(options)

        @format = options[:format] || '%m-%d %H:%M:%S'
      end

      def run
        time = Time.now.strftime(@format)
        info = {
          full_text: "⏲ #{time}",
          short_text: time,
          name: "time",
          urgent:  false,
          instance: "time",
        }.merge(@defaults)
        if ! @block.nil?
          @block.call(time, info)
          encode(info)
        else
          encode(info)
        end
      end
    end
  end
end
