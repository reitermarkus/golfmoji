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
      unless func
        puts 'ERROR: Command "' + cmd + '" not found!'
        return
      end

      @history.push(@stack.clone)

      begin
        # try to execute given command on the stack
        func.call(@stack)

        # if the command was successful, add the command to the stack
        @commands.push(Golfmoji.aliases.dig(cmd, :moji))
      rescue StandardError => e
        # get the backed up stack and set it as the new one
        @stack = @history.pop

        # print the error message
        p e
      end
    end

    def exec
      cmd = ''
      loop do
        puts 'Stack: ' + @stack.inspect
        print '> '

        cmd = read

        case cmd
        when 'back'
          back
        when /^help$/
          puts '🚨 Help:'
          puts '- Use "help <search pattern>" to search for commands.'
          puts '  (Pro tip 🤐: use "." to get all of them!)'
          puts '- Enter any command found from the list. If it works, the stack gets updated! 🎉'
          puts '- Enter "exit" to quit the em😮lator. This will print this resulting mojis and the final stack. 🚪'
          puts '  If supported, the em😮lator will copy the mojis to your 📋. Neat! 🕺'
          puts '- Enter "back" to jump back to the previous stack-state. ♻️ So handy 😀'
        when /^help ?(.*)/
          puts 'Available commands: 📜'
          s = $1
          p(Golfmoji.aliases.keys.sort.select { |e| /.*#{s}.*/ =~ e })
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

      if OS.linux?
        return
      end

      puts 'Info:'
      puts 'The source-code has been copied to your clip-board!'
      puts 'You may paste it into a new file or post it on a website.'
    end
  end
end

s = '👉👇👈👆'
8.times do |i|
  print("\rLoading the em😮lator " + s[i % 4])
  sleep 0.15
end
puts

Golfmoji::Emolator.new.exec
