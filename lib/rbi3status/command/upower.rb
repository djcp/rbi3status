module Rbi3status
  module Command
    class Upower < Base
      def run
        get_upower_info

        info = {
          full_text: full_message,
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

      def full_message
        if charging?
          %Q|⚡ CHR #{percent} #{time}|
        else
          %Q|⚡ BAT #{percent} #{time}|
        end
      end

      def get_upower_info
        @upower_info = `upower -i /org/freedesktop/UPower/devices/battery_BAT0`.split(/\n/)
      end

      def percent
        @upower_info.find{|f| f.match(/percentage/) }.split(':')[1].strip
      end

      def time
        @upower_info.find{|f| f.match(/time/) }.split(':')[1].strip
      end

      def state
        @upower_info.find{|f| f.match(/state/) }.split(':')[1].strip
      end

      def charging?
        state == 'charging'
      end
    end
  end
end
