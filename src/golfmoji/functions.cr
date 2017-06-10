module Golfmoji
    class Golfmojifunctions(A, B, R)
        include Comparable(A)
        include Comparable(B)

        FUNCTIONS = {
            '⛳' => {
                name: "golfmoji",
                type: :nilad,
                nilad: ->{ print("Hello World!") },
                monad: nil,
                bylad: nil
            },
            '🎲' => {
                name: "random",
                type: :nilad,
                nilad: ->{ p rand },
                monad: nil,
                bylad: nil
            },
            '⚖' => {
                name: "compare",
                type: :bylad,
                nilad: nil,
                monad: nil,
                bylad: ->(a : Int32, b : Int32) { a <=> b if a.is_a?(Comparable) && b.is_a?(Comparable) }
            }
        }
        def self.functions
            FUNCTIONS
        end
    end
end

f = Golfmoji::Golfmojifunctions.functions['⚖']["bylad"]
if f
    p f.call(5, 3)
end
