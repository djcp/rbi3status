require 'vmstat'
require 'oj'
require 'multi_json'

module Rbi3status
  module Command
    class Base
      attr_reader :defaults

      def initialize(options = {})
        @defaults = {
          separator_block_width: 31,
          separator: true,
          color: '#ffffff',
          urgent: false
        }.merge!(options)
      end

      def config(&block)
        @block = block
      end

      def vmstat
        @vmstat ||= Vmstat.snapshot
      end

      def encode(to_encode)
        MultiJson.encode(to_encode)
      end
    end
  end
end
