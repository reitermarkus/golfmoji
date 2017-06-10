module Golfmoji
    class Golfmojifunctions(A, B, R)
        include Comparable(A)
        include Comparable(B)

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
                func: ->(a : A, b : B) { a < b if a.is_a?(Comparable) && b.is_a?(Comparable) }
            }
        }
        def self.functions
            FUNCTIONS
        end
    end
end

p Golfmoji::Golfmojifunctions(Int32, Int32, Int32).functions['⚖']["func"].call(5, 3)
