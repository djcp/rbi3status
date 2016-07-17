$stdout.sync = true

module Rbi3status; end

require './lib/rbi3status/command/base'
require './lib/rbi3status/command/disk_free_percent'
require './lib/rbi3status/command/load_one'
require './lib/rbi3status/command/date_time'
require './lib/rbi3status/command/upower'
