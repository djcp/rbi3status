module Rbi3status
  class Harness
    @registry = []

    def register(*instances)
      @registry = instances
    end

    def render_line
      puts '['
      puts @registry.map{ |instance|
        if instance.class  == Class
          instance.new.run
        else
          instance.run
        end
      }.join(',')
      puts '],'
    end

    def render_all_in_loop(delay: 3)
      puts %Q|{"version": 1}[|

      while(true) do
        puts render_line
        sleep delay
      end
    end

  end
end
