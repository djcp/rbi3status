$stdout.sync = true

module Rbi3status; end

require './lib/rbi3status/command/base'
require './lib/rbi3status/command/disk_free_percent'
require './lib/rbi3status/command/load_one'
require './lib/rbi3status/command/date_time'
require './lib/rbi3status/command/upower'
require './lib/rbi3status/command/brightness'
require './lib/rbi3status/command/pulse_volume'
require './lib/rbi3status/command/yubikey'
