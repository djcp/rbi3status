#!/usr/bin/env ruby

require './lib/rbi3status'

puts %Q|{"version": 1}
[|

# Rbi3status::Command::Base.defaults(separator_block_width: 60)

while (true) do
  puts '['

  disk = Rbi3status::Command::DiskFreePercent.new(mount: '/')
  puts disk.run + ','

  load_one = Rbi3status::Command::LoadOne.new
  puts load_one.run + ','

  time = Rbi3status::Command::DateTime.new
  puts time.run + ','

  bat = Rbi3status::Command::Upower.new
  puts bat.run

  puts '],'
  sleep 2
end
