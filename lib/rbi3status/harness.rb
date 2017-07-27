module Rbi3status
  class Harness
    @registry = []

    def register(*instances)
      @registry = instances
    end

    def render_line
      puts '['
      puts @registry.map{ |instance|
        begin
          if instance.class == Class
            instance.new.run
          else
            instance.run
          end
        rescue => e
          logger.error e.inspect
          file.flush
        end
      }.join(',')
      puts '],'
    end

    def render_all_in_loop(delay: 3)
      puts %Q|{"version": 1}[|
      logger.info "Started up at: #{Time.now}"

      while(true) do
        logger.info "Rendering at: #{Time.now}"
        puts render_line
        sleep delay
      end
    end

    def logger
      dir = %Q|#{ENV['HOME']}/.rbi3status/logs|
      if ! File.directory?(dir)
        FileUtils.mkdir_p(dir)
      end

      file = File.open("#{dir}/rbi3status.log", 'a+')
      file.sync = true
      @logger ||= Logger.new(file, 10, 1024000)
    end
  end
end
