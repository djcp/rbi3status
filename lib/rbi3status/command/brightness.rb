module Rbi3status
  module Command
    class Brightness < Base
      attr_reader :max_brightness_device, :current_brightness_device

      def initialize(options = {})
        super(options)

        @max_brightness_device = options[:max_brightness_device] || '/sys/class/backlight/intel_backlight/max_brightness'
        @current_brightness_device = options[:current_brightness_device] || '/sys/class/backlight/intel_backlight/brightness'
      end

      def run
        max_brightness =`cat #{max_brightness_device}`.to_f
        current_brightness =`cat #{current_brightness_device}`.to_f
        brightness = (100 - ((max_brightness - current_brightness) / max_brightness) * 100).round(0)

        info = @defaults.merge({
          full_text: "💡 #{brightness}",
          short_text: "💡 #{brightness}",
          name: "brightness",
          instance: "brightness",
        })
        if ! @block.nil?
          @block.call(brightness, info)
          encode(info)
        else
          encode(info)
        end
      end
    end
  end
end
