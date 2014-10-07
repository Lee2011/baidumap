#!/usr/bin/env ruby
STDOUT.sync = true

$:.unshift File.join(File.dirname(__FILE__), *%w{ .. lib })

require 'baidumap'
require 'mercenary'

Mercenary.program(:baidumap) do |p|
  p.version Baidumap::VERSION
  p.description 'A ruby CLI tool for baidu map service API.'
  p.syntax 'baidumap <subcommand> [options]'

  Baidumap::Command.subclasses.each { |c| c.init_with_program(p) }

  p.action do |args, options|
    if args.empty?
      puts p
    else
      unless p.has_command?(args.first)
        Baidumap.logger.abort_with "Invalid command. Use --help for more information"
      end
    end
  end
end
