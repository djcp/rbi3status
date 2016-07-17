module Rbi3status
  module Command
    class LoadOne < Base
      def run
        load_one = vmstat.load_average.one_minute
        info = {
          full_text: "⚛ #{load_one}",
          short_text: load_one,
          name: "load_one",
          urgent: (load_one > 4) ? true : false,
          instance: "load_one",
        }.merge(@defaults)
        if ! @block.nil?
          @block.call(load_one, info)
          encode(info)
        else
          encode(info)
        end
      end
    end
  end
end
