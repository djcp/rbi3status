#!/usr/bin/env ruby

require './lib/rbi3status'

puts %Q|{"version": 1}
[|

# Rbi3status::Command::Base.defaults(separator_block_width: 60)

while (true) do
  puts '['

  bright = Rbi3status::Command::Brightness.new
  puts bright.run + ','

  yubi = Rbi3status::Command::Yubikey.new
  puts yubi.run + ','

  load_one = Rbi3status::Command::LoadOne.new
  load_one.config do |load_one, info|
    info[:color] = "#5f87ff"
  end
  puts load_one.run + ','

  disk = Rbi3status::Command::DiskFreePercent.new(mount: '/')
  disk.config do |free, info|
    info[:color] = '#005f5f'
  end
  puts disk.run + ','

  bat = Rbi3status::Command::Upower.new
  bat.config do |time, info|
    info[:color] = "#ffff00"
  end
  puts bat.run + ','

  time = Rbi3status::Command::DateTime.new
  time.config do |time, info|
    info[:color] = '#999999'
  end
  puts time.run + ','

  vol = Rbi3status::Command::PulseVolume.new
  puts vol.run

  puts '],'
  sleep 2
end
