module Golfmoji
  FUNCTIONS = {
    "🎲" => {
      name: "random",
      func: ->{ rand },
    },
    "⚖️" => {
      name: "compare",
      func: ->(a, b) { a <=> b },
    },
  }
end
