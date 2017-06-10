module Golfmoji
  class Golf
    def self.arity
      0
    end

    def self.call(*ignored)
      "Hello World!"
    end

    def self.moji
      '⛳'
    end
  end

  class Dice
    def self.arity
      0
    end

    def self.call(*ignored)
      rand
    end

    def self.moji
      '🎲'
    end
  end

  class Emoji_⚖
    def self.arity
      2
    end

    def self.call(a : Number | String, b : Number | String, *ignored)
      a <=> b
    end

    def self.call(a : Array(Number), b : Array(Number), *ignored)
      (a.zip b).map { |e|
        e[0] <=> e[1]
      }
    end

    def self.moji
      '⚖'
    end
  end

  FUNCTIONS = {
    '⛳' => Golf,
    '🎲' => Dice,
    '⚖' => Emoji_⚖,
  }

  def self.function(moji)
    FUNCTIONS[moji]
  end
end

f = Golfmoji.function('⚖')
if f
  p f.call(5, 4)
  p f.call([5, 3, 5], [2, 4, 5])
end
