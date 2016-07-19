module Rbi3status
  module Command
    class DateTime < Base
      def initialize(options = {})
        super(options)

        @format = options[:format] || '%m-%d %H:%M:%S'
      end

      def run
        time = Time.now.strftime(@format)
        info = @defaults.merge({
          full_text: "⏲ #{time}",
          short_text: time,
          name: "time",
          urgent:  false,
          instance: "time",
        })
        if ! @block.nil?
          @block.call(info, time)
          encode(info)
        else
          encode(info)
        end
      end
    end
  end
end
