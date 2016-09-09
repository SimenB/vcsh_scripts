#!/usr/bin/env ruby

# https://gist.github.com/orangeudav/26a8752ae54a169b8516

# Requirements:
#   brew install trash

casks_path = '/usr/local/Caskroom'

class Version < Array
  def initialize s
    super(s.split('.').map { |e| e.to_i })
  end
  def < x
    (self <=> x) < 0
  end
  def > x
    (self <=> x) > 0
  end
  def == x
    (self <=> x) == 0
  end
end

if `brew list | grep trash`.empty?
  puts 'Please make "brew install trash" before'
  exit!
end

Dir[File.join(casks_path, '*')].each do |cask_path|
  versions = Dir[File.join(cask_path,'*')].map{|i| File.basename(i)}

  next if versions.include?('latest')
  next if versions.size == 1

  versions.sort! do |b, a|
    a, b = Version.new(a), Version.new(b)
    if a == b
      0
    elsif a < b
      -1
    else
      1
    end
  end

  versions.shift
  versions.each do |version|
    path = File.join(cask_path, version)
    puts `trash #{path}`
  end
end
