#!/usr/bin/env ruby

require 'find'
require 'taglib'

def tag_mp4_files(dir)
  Find.find(dir) do |path|
    if path.end_with?('.mp4')
      filename = File.basename(path, '.mp4')
      parts = filename.split(' - ')
      if parts.length >= 3
        title = parts[2..-1].join(' - ')
        puts "Processing #{path}..."
        TagLib::MP4::File.open(path) do |file|
          tag = file.tag
          tag.title = title
          file.save
          puts "  Tagged with title: #{title}"
        end
      else
        warn "  Skipping #{path}: Not in 'SERIES_NAME - EPISODE - TITLE.mp4' format."
      end
    end
  end
end

if ARGV.length != 1
  puts "Usage: #{$0} <directory>"
  exit 1
end

target_directory = ARGV[0]

unless File.directory?(target_directory)
  puts "Error: #{target_directory} is not a valid directory."
  exit 1
end

tag_mp4_files(target_directory)
