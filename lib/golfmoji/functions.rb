# frozen_string_literal: true

require 'golfmoji/functions/math'

require 'json'

module Golfmoji
  @functions = {}

  def self.functions
    @functions
  end

  def self.moji(moji, func)
    @functions[moji] = func
  end
  private_class_method :moji

  # swap last 2 values in stack
  moji '🔀', lambda { |s|
    v1, v2 = s.pop(2)
    s.push v2
    s.push v1
  }

  # right-roll the stack
  moji '⏩', lambda { |s|
    v = s.pop
    s.reverse
    s.push v
    s.reverse
  }

  # reverse the stack
  moji '🔄', -> (s) { s.reverse }

  # print value
  moji '💬', ->(s) { p s.top }

  # put lowercase alphabeth
  moji '🔡', lambda { |s|
    s.push 'abcdefghijklmnopqrstuvwxyz'
  }

  # put uppercase alphabeth
  moji '🔠', lambda { |s|
    s.push 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
  }

  # put "Hello World!"
  # -> "Hello World!"
  moji '⛳️', ->(s) { s.push 'Hello world!' }

  # put ""
  # -> ""
  moji '🙊', ->(s) { s.push '' }

  # put " "
  # -> " "
  moji '🕸', ->(s) { s.push ' ' }

  # split string into an array of characters
  # "abc" -> ["a", "b", "c"]
  moji '💥', ->(s) { s.push s.pop.chars }

  # get array from string-array
  # "[1, 2, 3]" -> [1, 2, 3]
  moji '📃', lambda { |s|
    s.push JSON.parse(s.pop)
  }

  # reverse array
  # [1, 2, 3] -> [3, 2, 1]
  moji '↩', lambda { |s|
    s.push s.pop.reverse
  }

  # split string with string
  # "a b c", " " -> ["a", "b", "c"]
  moji '✂', lambda { |s|
    val, sep = s.pop(2)
    s.push val.split(sep)
  }

  # get ordinal value of char array or string
  # or get character of ordinal value
  moji '💱', lambda { |s|
    val = s.pop

    if val.is_a?(String)
      s.push(val.split('').map { |e| e.ord })
    else
      s.push(val.map { |e| e.chr })
    end
  }

  # get length of array (doesn't remove the array!)
  # [5, 8, "abc"] -> 3
  moji '🗜', lambda { |s|
    s.push s.top.length
  }

  # put first n characters of string
  moji '➡', lambda { |s|
    str, n = s.pop(2)
    s.push str[0...n.to_i]
  }

  # put last n characters of string
  moji '⬅', lambda { |s|
    str, n = s.pop(2)
    s.push str.reverse[0...n.to_i].reverse
  }

  # concatenate string (or array of strings) with string
  # "abc", "def" -> "abcdef"
  # ["a", "b", "c"], "def" -> ["adef", "bdef", "cdef"]
  moji '✏', lambda { |s|
    val, str = s.pop(2)
    if val.is_a?(Array)
      s.push(val.map { |e|
        e + str
      })
    else
      s.push val + str
    end
  }

  # check for uppercase
  # "Test" -> [true, false, false, false]
  moji '🔼', lambda { |s|
    s.push(s.top.split('').map { |e| e >= 'A' && e <= 'Z' })
  }

  # change upper/lower case
  moji '⏫', lambda { |s|
    val, val2 = s.pop(2)

    v = val.downcase
    val.length.times { |i| v[i] = val[i].upcase if val2[i] }

    s.push(v)
  }

  # check if value in list
  # [1, 2, 3], 2 -> true
  # [1, 2, 3], 5 -> false
  moji '🔍', lambda { |s|
    arr, val = s.pop(2)
    arr.include? val
  }

  # join array (with optional separator)
  # ["a", "b", "c"], "," -> "a,b,c"
  # ["a", "b", "c"] -> "abc"
  moji '🔗', lambda { |s|
    val = s.pop

    vals, sep = val.respond_to?(:each) ? [val, ''] : [s.pop, val]

    s.push vals.join(sep)
  }

  # copy current value at stack-head
  moji '©', ->(s) { s.push s.top }

  # append to array top value
  # [1, 2, 3], "3" -> [1, 2, 3, "3"]
  moji '🖇', lambda { |s|
    arr, val = s.pop(2)
    s.push arr << val
  }

  # zip each element of two arrays
  # ["a", "b", "c"], [1, 2, 3] -> [["a", 1], ["b", 2], ["c", 3]]
  moji '🎗', ->(s) { s.push s.pop.zip(s.pop) }

  # flatten an array
  # [[1, 2], ["a", "b"]] -> [1, 2, "a", "b"]
  moji '🚜', ->(s) { s.push s.pop.flatten }

  # surround string with string
  # "abc", "'" -> "'abc'"
  # ["a", "b", "c"] -> ["'a'", "'b'", "'c'"]
  moji '✉️', lambda { |s|
    val, sep = s.pop(2)
    if val.is_a?(Array)
      s.push(val.map { |e|
        sep + e + sep
      })
    else
      s.push sep + val + sep
    end
  }

  # collect all data in the stack and store it as one array-element holding the data
  moji '📦', lambda { |s|
    s.push(s.top(s.size))
  }

  # sum values
  # 1, 2 -> 3
  # [1, 2] -> 3
  moji '➕', lambda { |s|
    val = s.pop
    if val.is_a?(Array)
      v = 0
      val.each do |e|
        v += e
      end
      s.push v
    else
      val2 = s.pop
      s.push val + val2
    end
  }

  # multiply values
  # 2, 4 -> 8
  # [2, 4, 2] -> 16
  moji '✖️', lambda { |s|
    val, val2 = s.pop(2)
    if val.is_a?(Array)
      val = val.map { |e|
        e * val2
      }
      s.push val
    else
      s.push val * val2
    end
  }

  # divide values
  # 5, 2 -> 2.5
  # [10, 2, 5], 2 -> [5, 1, 2.5]
  moji '➗', lambda { |s|
    val, val2 = s.pop(2)
    if val.is_a?(Array)
      val = val.map { |e|
        e / val2.to_f
      }
      s.push val
    else
      s.push val / val2
    end
  }

  # xor values
  # "abc", 32 -> []
  moji '😵', lambda { |s|
    a, b = s.pop(2)

    b = b.to_i

    if a.respond_to?(:each)
      s.push(a.map { |e| e ^ b })
    else
      s.push(a ^ b)
    end
  }

  # n first fibonacci-values
  # 5 -> [0, 1, 1, 2, 3]
  moji '🐢', lambda { |s|
    s.push fib(s.pop.to_i - 1)
  }

  # check if given value is a fibonnaci-value
  # 5 -> true
  # 9 -> false
  moji '🔎', lambda { |s|
    s.push isfib(s.pop.to_i)
  }

  # group objects by occurances
  # [1, 1, 2, 3, 3, 3, 4] -> [[2, 4], [1], [3]]
  moji '🚬', lambda { |s|
    counts = Hash.new(0)

    s.pop.each do |e|
      counts[e] += 1
    end

    occurences = {}

    counts.each do |k, v|
      occurences[v] ||= []
      occurences[v] << k
    end

    s.push Hash[occurences.sort].values
  }
end
