# frozen_string_literal: true

$LOAD_PATH.unshift(__dir__)

require 'golfmoji/functions'
require 'golfmoji/stack'

module OS
  def self.windows?
    (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
  end

  def self.mac?
    (/darwin/ =~ RUBY_PLATFORM) != nil
  end

  def self.unix?
    !windows?
  end

  def self.linux?
    unix? && !mac?
  end
end

module Golfmoji
  class Emolator
    def initialize
      @stack = Golfmoji::Stack.new(ARGV)

      @history = []

      @commands = []
    end

    def read
      STDIN.gets("\n").rstrip
    end

    def back
      # reset to the newest backup stack
      @stack = @history.pop

      # remove the last command from the command history
      @commands.pop
    end

    def call(cmd)
      func = Golfmoji.aliases.dig(cmd, :func)
      unless func then
        puts 'ERROR: Command "' + cmd + '" not found!'
        return
      end

      @history.push(@stack.clone)

      begin
        # try to execute given command on the stack
        func.call(@stack)

        # if the command was successful, add the command to the stack
        @commands.push(Golfmoji.aliases.dig(cmd, :moji))
      rescue Exception => e
        # get the backed up stack and set it as the new one
        @stack = @history.pop

        # print the error message
        p e
      end
    end

    def exec
      cmd = ''
      while true
        puts 'Stack: ' + @stack.inspect
        print '> '

        cmd = read

        case cmd
        when 'back'
          back
        when /^help$/
          puts '🚨 Help:'
          puts 'Use "help <search pattern>" to search for commands. (Pro tip 🤐: use "." to get all of them!)'
        when /^help ?(.*)/
          puts 'Available commands:'
          s = $1
          p Golfmoji.aliases.keys.sort.select {|e| /.*#{s}.*/ =~ e}
        when 'help'
          puts 'Available commands:'
          s = $1
          p Golfmoji.aliases.keys.sort.select {|e| /.*#{s}.*/ =~ e}
        when 'exit'
          break
        else
          call(cmd)
        end
      end

      puts 'Stack: ' + @stack.inspect
      puts 'Commands: ' + @commands.join.inspect

      if OS.mac?
        IO.popen('pbcopy', 'w') do |f|
          f << @commands.join
        end
      elsif OS.windows?
        IO.popen('clip', 'w') do |f|
          f << @commands.join
        end
      end

      if OS.mac? or OS.windows?
        puts 'Info:'
        puts 'The source-code has been copied to your clip-board!'
        puts 'You may paste it into a new file or post it on a website.'
      end
    end
  end
end

Golfmoji::Emolator.new.exec
