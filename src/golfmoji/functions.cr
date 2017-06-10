module Golfmoji
  FUNCTIONS = {
    '⛳' => {
      name: "golfmoji",
      func: ->{ print("Hello World!") }
    },
    '🎲' => {
      name: "random",
      func: ->{ rand }
    },
    '⚖' => {
      name: "compare",
      func: ->(a, b) { a <=> b }
    }
  }
end
