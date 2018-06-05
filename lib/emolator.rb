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
      @stack = Golfmoji::Stack.new([])

      @history = []

      @commands = []

      @funcs = {
        '0' => '0️⃣',
        '1' => '1️⃣',
        '2' => '2️⃣',
        '3' => '3️⃣',
        '4' => '4️⃣',
        '5' => '5️⃣',
        '6' => '6️⃣',
        '7' => '7️⃣',
        '8' => '8️⃣',
        '9' => '9️⃣',
        '+' => '➕',
        'plus' => '➕',
        '-' => '➖',
        'minus' => '➖',
        'sum' => '➕',
        '*' => '✖️',
        'mul' => '✖️',
        '/' => '➗',
        'div' => '➗',
        'empty' => '🙊'
      }
    end

    def read
      STDIN.gets("\n").rstrip
    end

    def start
      p @stack

      cmd = ''
      until cmd == 'exit' do
        cmd = read

        if cmd == 'back' then
          @stack = @history.pop.clone
          @commands.pop

          p @stack
          p @history
          next
        end

        func = Golfmoji.functions[@funcs[cmd]]
        unless func then
          p cmd
          break
        end

        @history.push(@stack.clone)

        func.call(@stack)

        @commands.push(@funcs[cmd])

        p @stack
        p @history
      end

      p @stack
      p @history
      p @commands.join

      if OS.mac?
        IO.popen('pbcopy', 'w') do |f|
          f << @commands.join
        end

        puts 'Info:'
        puts 'The source-code has been copied to your clip-board!'
        puts 'You may paste it into a new file or post it on a website.'
      else
        print("\n" + src.join + "\n\n")
      end
    end
  end
end

Golfmoji::Emolator.new().start

# if !ARGV.empty?
#   # we have a file given. Read it or exit if the given file doesn't exist
#   unless File.exist?(ARGV.first)
#     STDERR.puts "Error: '" + ARGV.first + "' doesn't exist!"
#     exit 1
#   end

#   src = File.read(ARGV.first).rstrip.split("\n")
# else
#   # we don't have a file given, so we ask for input

#   print("Please enter the source-code you want to parse:\n(finish with an empty line)\n\n")
#   src = STDIN.gets("\n\n").rstrip.split("\n")
# end

# src = src.map { |i|
#   funcs[i]
# }
