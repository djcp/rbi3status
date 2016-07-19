module Rbi3status
  module Command
    class Upower < Base
      attr_reader :device

      def initialize(options = {})
        super(options)

        @device = options[:device] || '/org/freedesktop/UPower/devices/battery_BAT0'
      end

      def run
        get_upower_info

        info = @defaults.merge({
          full_text: full_message,
          short_text: full_message,
          name: "time remaining",
          urgent:  (percent.to_i < 10) ? true : false,
          instance: "time_remaining",
        })
        if ! @block.nil?
          @block.call(info, time)
          encode(info)
        else
          encode(info)
        end
      end

      def full_message
        if full?
          %Q|⚡ CHR #{percent}|
        elsif charging?
          %Q|⚡ CHR #{percent} #{time}|
        else
          %Q|⚡ BAT #{percent} #{time}|
        end
      end

      def get_upower_info
        @upower_info = `upower -i #{device}`.split(/\n/)
      end

      def full?
        time.nil?
      end

      def percent
        @upower_info.find{ |f| f.match(/percentage/) }.split(':')[1].strip
      end

      def time
        time_attribute = @upower_info.find{ |f| f.match(/time/) }
        time_attribute.split(':')[1].strip if time_attribute
      end

      def state
        @upower_info.find{ |f| f.match(/state/) }.split(':')[1].strip
      end

      def charging?
        state == 'charging'
      end
    end
  end
end
