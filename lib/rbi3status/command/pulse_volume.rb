module Rbi3status
  module Command
    class PulseVolume < Base
      def run
        volume = get_volume

        info = @defaults.merge({
          full_text: "♬ #{volume}",
          short_text: "♬ #{volume}",
          name: "volume",
          urgent:  false,
          instance: "volume",
        })
        if ! @block.nil?
          @block.call(volume, info)
          encode(info)
        else
          encode(info)
        end
      end

      def get_volume
        vol_info = `pacmd list-sinks`.split(/\n/).find { |line| line.match(/	volume:/) }.scan(/\d+%/).first
      end
    end
  end
end
