#!/usr/bin/env ruby
require './lib/rbi3status'

Rbi3status::Command::Base.defaults[:color] = '#ffffff'
# Rbi3status::Command::Base.defaults[:markup] = 'pango'

harness = Rbi3status::Harness.new

harness.register(
  Rbi3status::Command::Brightness,
  Rbi3status::Command::Yubikey,
  Rbi3status::Command::LoadOne.new.config {|info, load_one| info[:color] = "#5f87ff" },
  Rbi3status::Command::DiskFreePercent.new(mount: '/').config { |info, free| info[:color] = '#999999'},
  Rbi3status::Command::Upower.new.config { |info, power| info[:color] = "#ffff00" },
  Rbi3status::Command::DateTime.new.config { |info, time| info[:color] = '#999999'; info[:full_text] = "⌚ #{time}" },
  Rbi3status::Command::PulseVolume
)

harness.render_all_in_loop(delay: 3)
