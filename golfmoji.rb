FUNCTIONS = {
    '⛳' => {
        name: "golfmoji",
        func: ->{ print("Hello World!\n") }
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

mojicode = ['⛳','🎲']

mojicode.each do |c|
    p FUNCTIONS[c][:func].call
    p FUNCTIONS['⚖'][:func].call(3,2)
end
