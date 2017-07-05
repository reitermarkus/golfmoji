# frozen_string_literal: true

require 'delegate'

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
    s.put v2
    s.put v1
  }

  # print value
  moji '💬', ->(s) { p s.peek }

  # put lowercase alphabeth
  moji '🔡', lambda { |s|
    s.put 'abcdefghijklmnopqrstuvwxyz'
  }

  # put uppercase alphabeth
  moji '🔠', lambda { |s|
    s.put 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
  }

  # put "Hello World!"
  # -> "Hello World!"
  moji '⛳', ->(s) { s.put 'Hello World!' }

  # put ""
  # -> ""
  moji '🙊', ->(s) { s.put '' }

  # split string into an array of characters
  # "abc" -> ["a", "b", "c"]
  moji '💥', ->(s) { s.put s.pop.chars }

  # get array from string-array
  # "[1, 2, 3]" -> [1, 2, 3]
  moji '📃', lambda { |s|
    s.put JSON.parse s.pop
  }

  # reverse array
  # [1, 2, 3] -> [3, 2, 1]
  moji '↩', lambda { |s|
    s.put s.pop.reverse
  }

  # split string with string
  # "a, b, c", ", " -> ["a", "b", "c"]
  moji '✂', lambda { |s|
    val, sep = s.pop(2)
    s.put val.split(sep)
  }

  # put first n characters of string
  moji '➡', lambda { |s|
    str, n = s.pop(2)
    s.put str[0...n.to_i]
  }

  # put last n characters of string
  moji '⬅', lambda { |s|
    str, n = s.pop(2)
    s.put str.reverse[0...n.to_i].reverse
  }

  # concatenate string (or array of strings) with string
  # "abc", "def" -> "abcdef"
  # ["a", "b", "c"], "def" -> ["adef", "bdef", "cdef"]
  moji '✏', lambda { |s|
    val, str = s.pop(2)
    if val.is_a?(Array)
      s.put(val.map { |e|
        e + str
      })
    else
      s.put val + str
    end
  }

  # check if value in list
  # [1, 2, 3], 2 -> true
  # [1, 2, 3], 5 -> false
  moji '🔍', lambda { |s|
    arr, val = s.pop(2)
    arr.include? val
  }

  # join string with string
  # ["a", "b", "c"], "," -> "a,b,c"
  # ["a", "b", "c"], "" -> "abc"
  moji '🔗', lambda { |s|
    val, sep = s.pop(2)
    s.put val.join(sep)
  }

  # copy current value at stack-head
  moji '©', ->(s) { s.put s.peek }

  # append to array top value
  # [1, 2, 3], "3" -> [1, 2, 3, "3"]
  moji '🖇', lambda { |s|
    arr, val = s.pop(2)
    s.put arr << val
  }

  # zip each element of two arrays
  # ["a", "b", "c"], [1, 2, 3] -> [["a", 1], ["b", 2], ["c", 3]]
  moji '🎗', ->(s) { s.put s.pop.zip(s.pop) }

  # flatten an array
  # [[1, 2], ["a", "b"]] -> [1, 2, "a", "b"]
  moji '🚜', ->(s) { s.put s.pop.flatten }

  # surround string with string
  # "abc", "'" -> "'abc'"
  # ["a", "b", "c"] -> ["'a'", "'b'", "'c'"]
  moji '📦', lambda { |s|
    val, sep = s.pop(2)
    if val.is_a?(Array)
      s.put(val.map { |e|
        sep + e + sep
      })
    else
      s.put sep + val + sep
    end
  }

  # sum values
  # 1, 2 -> 3
  # [1, 2] -> 3
  moji '➕', lambda { |s|
    val = s.pop
    if val.is_a?(Array)
      s.put val.sum
    else
      val2 = s.pop
      s.put val + val2
    end
  }

  # n first fibonacci-values
  # 5 -> [0, 1, 1, 2, 3]
  moji '🐢', lambda { |s|
    s.put fib(s.pop.to_i - 1)
  }

  # check if given value is a fibonnaci-value
  # 5 -> true
  # 9 -> false
  moji '🔎', lambda { |s|
    s.put isfib(s.pop.to_i)
  }

  # group objects by occurances
  # [1, 1, 2, 3, 3, 3, 4] -> [[2, 4], [1], [3]]
  moji '🚬', lambda { |s|
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
    arr = occs.sort.map { |e|
      p e[1]
    }
    s.put arr
  }
end
