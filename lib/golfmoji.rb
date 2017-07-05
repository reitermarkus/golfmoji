$LOAD_PATH.unshift(__dir__)

require 'golfmoji/version'
require 'golfmoji/functions'

require 'json'

def fib(n)
  # if n == 0
  #	[0]
  # elsif n == 1
  #	[0, 1]
  # else
  #	f = fib(n - 1)
  #	e = f[(f.size - 2)...f.size]
  #	f << (e[0] + e[1])
  # end
  if n.zero?
    [0]
  elsif n == 1
    [0, 1]
  else
    fibs = [0, 1]
    (n - 1).times do
      s = fibs.size
      fibs << (fibs[s - 2] + fibs[s - 1])
    end
    fibs
  end
end

def isfib(n)
  !(fib(n + 2) & [n]).empty?
end

module Golfmoji
  @stack = []

  def self.clear
    @stack.clear
  end

  def self.input
    ARGV.each do |arg|
      @stack << arg
    end
  end

  def self.reset(arr)
    clear
    arr.each do |e|
      @stack << e
    end
  end

  def self.put(val)
    @stack << val
  end

  def self.peek
    @stack.last
  end

  def self.pop(n = 1)
    if n == 1
      @stack.pop(n)[0]
    else
      @stack.pop(n)
    end
  end

  def self.exec(moji)
    f = functions[moji]
    if f
      f.call(Golfmoji)
    else
      put(moji)
    end
  end
end
