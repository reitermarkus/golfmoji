module Nilad
    def arity; 0; end
    def call; end
end

module Monad
    def arity; 1; end
    def call(a : Object); end
end

module Dyad
    def arity; 2; end
    def call(a : Object, b : Object); end
end

alias Function = Nilad | Monad | Dyad

module Golfmoji
    FUNCTIONS = {} of String => Function

    macro moji(name, *args, &block)
        class Emoji_{{name.id}}
            include
                {% if args.size == 0 %}
                Nilad
                {% elsif args.size == 1 %}
                Monad
                {% else %}
                Dyad
                {% end %}
            {% if args.size == 0 %}
                def call
                    {{block.body}}
                end
            {% else %}
                def call({{*args}})
                    {{block.body}}
                end
            {% end %}
            def moji
                {{name}}
            end
        end

        FUNCTIONS[{{name}}] = Emoji_{{name.id}}.new.as(Function)
    end

    moji "⛳" {
        "Hello World!"
    }

    moji "🎲" {
        rand
    }

    moji "⚖", a : Array, b : Array {
        a.zip(b).map { |e| e[0] <=> e[1] }
    }

    moji "⚖", a : Number, b : Number { a <=> b }
    moji "⚖", a : String, b : String { a <=> b }

    moji "0️⃣" {  0.0 }
    moji "1️⃣" {  1.0 }
    moji "2️⃣" {  2.0 }
    moji "3️⃣" {  3.0 }
    moji "4️⃣" {  4.0 }
    moji "5️⃣" {  5.0 }
    moji "6️⃣" {  6.0 }
    moji "7️⃣" {  7.0 }
    moji "8️⃣" {  8.0 }
    moji "9️⃣" {  9.0 }
    moji "🔟" { 10.0 }

    moji "➕", a : Number, b : Number { a + b }
    moji "➕", a : String, b : Number { a + b.to_s }
    moji "➖", a : Number, b : Number { a - b }
    moji "➗", a : Number, b : Number { a / b }
    moji "✖", a : Number, b : Number { a * b }
    moji "✖", a : String, b : Number { a * b.to_i }

    moji "💥", a : String { a.chars.each &.to_s }

    def self.function(moji)
        FUNCTIONS[moji]
    end

    def self.exec(src)

        print("\nexecuting:\n" + src.to_s + ":\n\n");

        value = nil

        applicators = [] of Dyad

        src.each do |moji|
        function = Golfmoji.function(moji)

        case function.arity

            when 0
puts "Arity 0: #{function}"
                tmp = function.as(Nilad).call
puts "Temp value: " + tmp.inspect
                until applicators.empty?
                    app = applicators.pop
puts "Applying #{app}."
                    tmp = app.call(value, tmp)
                end

                value = tmp

            when 1

                tmp = function.as(Monad).call(value)
puts "Temp value: " + tmp.inspect
                until applicators.empty?
                    app = applicators.pop
puts "Applying #{app}."
                    tmp = app.call(value, tmp).not_nil!
                end

                value = tmp

            else
puts "Adding applicator #{function}"
                applicators << function.as(Dyad)

            end

        end

        value

    end
end
