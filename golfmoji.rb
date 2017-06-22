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
  FUNCTIONS = {}.freeze
  STACK = [].freeze

  def self.clear
    STACK.clear
  end

  def self.input
    ARGV.each do |arg|
      STACK << arg
    end
  end

  def self.reset(arr)
    clear
    arr.each do |e|
      STACK << e
    end
  end

  def self.put(val)
    STACK << val
  end

  def self.peek
    STACK.last
  end

  def self.pop(n = 1)
    if n == 1
      STACK.pop(n)[0]
    else
      STACK.pop(n)
    end
  end

  def self.add_function(moji, func)
    FUNCTIONS[moji] = func
  end

  def self.exec(moji)
    f = FUNCTIONS[moji]
    if f
      f.call(Golfmoji)
    else
      put(moji)
    end
  end

  # swap last 2 values in stack
  add_function('🔀', lambda { |s|
    v1, v2 = s.pop(2)
    s.put v2
    s.put v1
  })

  # print value
  add_function('💬', ->(s) { p s.peek })

  # put lowercase alphabeth
  add_function('🔡', lambda { |s|
    s.put 'abcdefghijklmnopqrstuvwxyz'
  })

  # put uppercase alphabeth
  add_function('🔠', lambda { |s|
    s.put 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
  })

  # put "Hello World!"
  # -> "Hello World!"
  add_function('⛳', ->(s) { s.put 'Hello World!' })

  # put ""
  # -> ""
  add_function('🙊', ->(s) { s.put '' })

  # split string into an array of characters
  # "abc" -> ["a", "b", "c"]
  add_function('💥', ->(s) { s.put s.pop.chars })

  # get array from string-array
  # "[1, 2, 3]" -> [1, 2, 3]
  add_function('📃', lambda { |s|
    s.put JSON.parse s.pop
  })

  # reverse array
  # [1, 2, 3] -> [3, 2, 1]
  add_function('↩', lambda { |s|
    s.put s.pop.reverse
  })

  # split string with string
  # "a, b, c", ", " -> ["a", "b", "c"]
  add_function('✂', lambda { |s|
    val, sep = s.pop(2)
    s.put val.split(sep)
  })

  # put first n characters of string
  add_function('➡', lambda { |s|
    str, n = s.pop(2)
    s.put str[0...n.to_i]
  })

  # put last n characters of string
  add_function('⬅', lambda { |s|
    str, n = s.pop(2)
    s.put str.reverse[0...n.to_i].reverse
  })

  # concatenate string (or array of strings) with string
  # "abc", "def" -> "abcdef"
  # ["a", "b", "c"], "def" -> ["adef", "bdef", "cdef"]
  add_function('✏', lambda { |s|
    val, str = s.pop(2)
    if val.is_a?(Array)
      s.put(val.map { |e|
        e + str
      })
    else
      s.put val + str
    end
  })

  # check if value in list
  # [1, 2, 3], 2 -> true
  # [1, 2, 3], 5 -> false
  add_function('🔍', lambda { |s|
    arr, val = s.pop(2)
    arr.include? val
  })

  # join string with string
  # ["a", "b", "c"], "," -> "a,b,c"
  # ["a", "b", "c"], "" -> "abc"
  add_function('🔗', lambda { |s|
    val, sep = s.pop(2)
    s.put val.join(sep)
  })

  # copy current value at stack-head
  add_function('©', ->(s) { s.put s.peek })

  # append to array top value
  # [1, 2, 3], "3" -> [1, 2, 3, "3"]
  add_function("\u{1F587}", lambda { |s|
    arr, val = s.pop(2)
    s.put arr << val
  })

  # zip each element of two arrays
  # ["a", "b", "c"], [1, 2, 3] -> [["a", 1], ["b", 2], ["c", 3]]
  add_function("\u{1F397}", ->(s) { s.put s.pop.zip(s.pop) })

  # flatten an array
  # [[1, 2], ["a", "b"]] -> [1, 2, "a", "b"]
  add_function('🚜', ->(s) { s.put s.pop.flatten })

  # surround string with string
  # "abc", "'" -> "'abc'"
  # ["a", "b", "c"] -> ["'a'", "'b'", "'c'"]
  add_function('📦', lambda { |s|
    val, sep = s.pop(2)
    if val.is_a?(Array)
      s.put(val.map { |e|
        sep + e + sep
      })
    else
      s.put sep + val + sep
    end
  })

  # sum values
  # 1, 2 -> 3
  # [1, 2] -> 3
  add_function('➕', lambda { |s|
    val = s.pop
    if val.is_a?(Array)
      s.put val.sum
    else
      val2 = s.pop
      s.put val + val2
    end
  })

  # n first fibonacci-values
  # 5 -> [0, 1, 1, 2, 3]
  add_function('🐢', lambda { |s|
    s.put fib(s.pop.to_i - 1)
  })

  # check if given value is a fibonnaci-value
  # 5 -> true
  # 9 -> false
  add_function('🔎', lambda { |s|
    s.put isfib(s.pop.to_i)
  })

  # group objects by occurances
  # [1, 1, 2, 3, 3, 3, 4] -> [[2, 4], [1], [3]]
  add_function('🚬', lambda { |s|
    a = s.pop
    cnts = Hash.new 0
    a.each do |e|
      cnts[e] += 1
    end
    occs = {}
    cnts.to_a.each do |e|
      if occs[e[1]]
        occs[e[1]] << e[0]
      else
        occs[e[1]] = [e[0]]
      end
    end
    arr = occs.sort.map do |e|
      p e[1]
    end
    s.put arr
  })

  ['⛳', '💥', '©', "\u{1F397}"].each do |f|
    exec(f)
  end
  p 'result:'
  p peek

  ['⛳', '💥', "'", '📦', '🙊', '🔗'].each do |f|
    exec(f)
  end
  p 'result:'
  p peek

  ['⛳', ' ', '✂', '-', '🔗'].each do |f|
    exec(f)
  end
  p 'result:'
  p peek

  ['⛳', ' ', '✂', '⛳', '✏'].each do |f|
    exec(f)
  end
  p 'result:'
  p peek

  # https://codegolf.stackexchange.com/questions/126410/sugar-free-syntax
  reset(['abc']) # = input
  ['💥', "'", '📦', '[]', "\u{1F587}", ':', '🔗'].each do |f|
    exec(f)
  end
  p 'result:'
  p peek

  # https://codegolf.stackexchange.com/questions/126373/am-i-a-fibonacci-number
  reset(['4']) # = input
  ['🔎'].each do |f|
    exec(f)
  end
  p 'result:'
  p peek

  # https://codegolf.stackexchange.com/questions/126159/group-a-list-by-frequency
  reset(['[1,1,1,4,5,6,6,6,7,7,8,8,8,8,8,8,8,9,5,6,5,6,5,6,5,6,-56]'])
  ['📃', '🚬'].each do |f|
    exec(f)
  end
  p 'result:'
  p peek
end
