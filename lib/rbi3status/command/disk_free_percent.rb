module Rbi3status
  module Command
    class DiskFreePercent < Base
      attr_reader :mount

      def initialize(options = {})
        super(options)

        @mount = options[:mount]
      end

      def run
        disk = vmstat.disks.find{ |disk| disk.mount == mount }
        disk_free_percent = (100 - (((disk.total_blocks - disk.free_blocks ) / disk.total_blocks.to_f) * 100)).round(1)
        info = @defaults.merge({
          full_text: "◎ #{disk_free_percent}% free on #{mount}",
          short_text: disk_free_percent,
          name: "disk_free_percent",
          urgent: (disk_free_percent < 10) ? true : false,
          instance: "#{mount}_free",
        })
        if ! @block.nil?
          @block.call(info, disk_free_percent)
          encode(info)
        else
          encode(info)
        end
      end
    end
  end
end
