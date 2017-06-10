macro num
    Golfmoji::Num
end

macro num(val)
    num.new({{val}})
end

module Golfmoji

    class Num
        @val : Int32 | Float64

        def initialize(val)
            @val = val
        end

        def <=>(o)
            num(@val <=> o.val)
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

    FUNCTIONS = {
        '⛳' => {
            name: "golfmoji",
            nilad: ->{ print("Hello World!") },
            monad: nil,
            bylad: nil
        },
        '🎲' => {
            name: "random",
            nilad: ->{ p rand },
            monad: nil,
            bylad: nil
        },
        '⚖' => {
            name: "compare",
            nilad: nil,
            monad: nil,
            bylad: ->(a : Golfmoji::Num | Array(Golfmoji::Num), b : Golfmoji::Num | Array(Golfmoji::Num)) {
                if a.is_a?(Array(Golfmoji::Num)) && b.is_a?(Array(Golfmoji::Num))
                    (a.zip b).map do |e|
                        e[0] <=> e[1]
                    end
                elsif a.is_a?(Array(Golfmoji::Num)) && b.is_a?(Golfmoji::Num)
                    a.map do |e|
                        e <=> b
                    end
                elsif a.is_a?(Golfmoji::Num) && b.is_a?(Array(Golfmoji::Num))
                    b.map do |e|
                        e <=> a
                    end
                elsif a.is_a?(Golfmoji::Num) && b.is_a?(Golfmoji::Num)
                    a <=> b
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
    p f.arity
    p f.call(num(5), num(3))
    p f.call([num(5), num(3), num(5)], [num(2), num(4), num(5)])
end
