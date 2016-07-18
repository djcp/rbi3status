module Rbi3status
  module Command
    class Yubikey < Base
      attr_reader :yubitoggle_cmd

      def initialize(options = {})
        super(options)

        @yubitoggle_cmd = options[:yubitoggle_cmd] || '~/bin/yubitoggle --state'
      end

      def run
        state = get_yubitoggle_state
        if state == 'on'
          color = "#00ff00"
        else
          color = "#ff0000"
        end

        info = @defaults.merge({
          full_text: "🔑  #{state}",
          short_text: "🔑  #{state}",
          name: "yubikey",
          instance: "yubikey",
          color: color
        })
        if ! @block.nil?
          @block.call(state, info)
          encode(info)
        else
          encode(info)
        end
      end

      def get_yubitoggle_state
        output = `#{yubitoggle_cmd}`.to_i
        if output == 0
          'off'
        else
          'on'
        end
      end
    end
  end
end
