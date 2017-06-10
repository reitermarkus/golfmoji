macro num(val)
    Golfmoji::Num.new({{val}})
end

macro arr(arr)
    Golfmoji::Arr.new({{arr}})
end

module Golfmoji

    class Num
        @val : Int32 | Float64

        def initialize(val)
            @val = val
        end

        def <=>(o)
            @val <=> o.val
        end

        def val
            @val
        end

        def inspect(io)
            io << @val.to_s
        end

        def to_s(io)
            io << @val.to_s
        end
    end

    class Arr
        @a : Array(Golfmoji::Num)

        def initialize(a)
            @a = a
        end

        def <=>(o)
            @a <=> o.a
        end

        def a
            @a
        end

        def inspect(io)
            io << @a.to_s
        end

        def to_s(io)
            io << @a.to_s
        end
    end

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
            bylad: ->(a : Golfmoji::Num | Golfmoji::Arr, b : Golfmoji::Num | Golfmoji::Arr) {
                if a.is_a?(Golfmoji::Arr) && b.is_a?(Golfmoji::Arr)
                    arr([num(a <=> b)])
                elsif a.is_a?(Golfmoji::Num) && b.is_a?(Golfmoji::Num)
                    Golfmoji::Num.new(a <=> b)
                end
            }
        }
    }

    def self.functions
        FUNCTIONS
    end
end

f = Golfmoji.functions['⚖']["bylad"]
if f
    p f.call(num(5), num(3))
    p f.call(arr([num(5), num(3)]), arr([num(4), num(2)]))
end
