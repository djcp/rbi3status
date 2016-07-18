#!/usr/bin/env ruby

require './lib/rbi3status'

puts %Q|{"version": 1}
[|

# Rbi3status::Command::Base.defaults(separator_block_width: 60)

while (true) do
  puts '['

  yubi = Rbi3status::Command::Yubikey.new
  puts yubi.run + ','

  bright = Rbi3status::Command::Brightness.new
  puts bright.run + ','

  load_one = Rbi3status::Command::LoadOne.new
  puts load_one.run + ','

  disk = Rbi3status::Command::DiskFreePercent.new(mount: '/')
  puts disk.run + ','

  time = Rbi3status::Command::DateTime.new
  puts time.run + ','

  bat = Rbi3status::Command::Upower.new
  puts bat.run + ','

  vol = Rbi3status::Command::PulseVolume.new
  puts vol.run

  puts '],'
  sleep 2
end
