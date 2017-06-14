module Nilad
    def arity; 0; end
    def call; end
end

module Monad
    def arity; 1; end
    def call(a); end
end

module Dyad
    def arity; 2; end
    def call(a, b); end
end

module Golfmoji

    alias Typ = Nil | Int32 | Float64 | Char | String | Regex | Array(Typ) | Hash(Typ, Typ) | Tuple(Typ)
    alias Function = Nilad | Monad | Dyad

    FUNCTIONS = {} of String => Function

    @@last_chain : Golfmoji::Typ
    @@last_chain = 0

    def self.last_chain
        @@last_chain
    end

    def self.last_chain=(v)
        @@last_chain = v
    end

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
            def inspect(io)
                io << self.to_s(io)
            end
            def to_s(io)
                io << "{{name.id}}"
            end
        end

        FUNCTIONS[{{name}}] = Emoji_{{name.id}}.new.as(Function)
    end

    # access result of previous chain
    moji "🔗" { Golfmoji.last_chain }

    # values
    moji "⛳" { "Hello World!" }
    moji "🎲" { rand }
    moji "🙊" { "" }

    # printing
    moji "💬", a : Object { print(a.to_s + "\n") }

    # strings
    moji "😢", a : String { a.downcase }
    moji "😀", a : String { a.upcase }
    moji "🙃", a : String { a.reverse }
    moji "💥", a : String { a.chars }
    moji "✂", a : String, b : String { a.split(b) }
    moji "✂", a : String, b : Regex { a.split(b) }
    moji "🖇", a : Array(String), b : String { a.join(b) }
    moji "👓", a : String { /#{a}/ }
#    moji "👓", a : String, b : String { a.partition(/#{b}/) } # causes invalid memory access
    moji "➕", a : String, b : Number { a + b.to_s }
    moji "✖", a : String, b : Int { a * b }

    # booleans
#    moji "🚨", 

    # arrays
    moji "👇", a : Array { a[0] }
    moji "🖕", a : Array, b : Int { a[b] }
    moji "🖕", a : Array, b : Range { a[b] }
    moji "🚜", a : Array { a.flatten }
    moji "➿", a : Array(String), b : Array(String) {
        (a.zip b).map &.to_a
    }
    moji "➿", a : Array(Char), b : Array(Char) {
        (a.zip b).map &.to_a
    }
    moji "➿", a : Array(Char), b : Array(String) {
        (a.zip b).map &.to_a
    }
    moji "➿", a : Array(String), b : Array(Char) {
        (a.zip b).map &.to_a
    }
    moji "➿", a : Array(Int), b : Array(Int) {
        (a.zip b).map &.to_a
    }
    moji "➿", a : Array(Float), b : Array(Float) {
        (a.zip b).map &.to_a
    }
    moji "➿", a : Array(Int), b : Array(Float) {
        (a.zip b).map &.to_a
    }
    moji "➿", a : Array(Float), b : Array(Int) {
        (a.zip b).map &.to_a
    }
    moji "➿", a : Array(Int), b : Array(String) {
        (a.zip b).map &.to_a
    }
    moji "➿", a : Array(String), b : Array(Int) {
        (a.zip b).map &.to_a
    }
    moji "➿", a : Array(Int), b : Array(Char) {
        (a.zip b).map &.to_a
    }
    moji "➿", a : Array(Char), b : Array(Int) {
        (a.zip b).map &.to_a
    }
    moji "➿", a : Array(Float), b : Array(String) {
        (a.zip b).map &.to_a
    }
    moji "➿", a : Array(String), b : Array(Float) {
        (a.zip b).map &.to_a
    }
    moji "➿", a : Array(Float), b : Array(Char) {
        (a.zip b).map &.to_a
    }
    moji "➿", a : Array(Char), b : Array(Float) {
        (a.zip b).map &.to_a
    }

    # numbers
    moji "🁣" {  0.0 }
    moji "🁤" {  1.0 }
    moji "🁫" {  2.0 }
    moji "🁬" {  3.0 }
    moji "🁳" {  4.0 }
    moji "🁴" {  5.0 }
    moji "🁻" {  6.0 }
    moji "🁼" {  7.0 }
    moji "🂃" {  8.0 }
    moji "🂄" {  9.0 }
    moji "🂋" { 10.0 }
    moji "🂌" { 11.0 }
    moji "🂓" { 12.0 }
    moji "⇢", a : Int { (0..a).to_a }
    moji "→", a : Int, b : Int { (a..b).to_a }

    # comparing
    moji "⚖", a : Number, b : Number { a <=> b }
    moji "⚖", a : String, b : String { a <=> b }
    moji "⚖", a : Array(Int), b : Array(Int) {
        a.zip(b).map { |e| e[0] <=> e[1] }
    }
    moji "⚖", a : Array(Float), b : Array(Float) {
        a.zip(b).map { |e| e[0] <=> e[1] }
    }
    moji "⚖", a : Array(Char), b : Array(Char) {
        a.zip(b).map { |e| e[0] <=> e[1] }
    }

    # math
    moji "😢", a : Number { -a }
    moji "😢", a : String { -a.to_f }
    moji "➕", a : Number, b : Number { a + b }
    moji "➕", a : String, b : String { a.to_f + b.to_f }
    moji "➖", a : Number, b : Number { a - b }
    moji "➖", a : String, b : String { a.to_f - b.to_f }
    moji "➗", a : Number, b : Number { a / b }
    moji "➗", a : String, b : String { a.to_f / b.to_f }
    moji "✖", a : Number, b : Number { a * b }
    moji "✖", a : String, b : String { a.to_f * b.to_f }
    moji "✔", a : Number { Math.sqrt(a) }
    moji "✔", a : String { Math.sqrt(a.to_f) }
    moji "✔", a : Array(Number) {
        a.map { |e| Math.sqrt(e) }
    }
    moji "✔", a : Array(String) {
        a.map { |e| Math.sqrt(e.to_f) }
    }

    def self.function(moji)
        FUNCTIONS[moji]
    end

    def self.exec_chain(chain)

        print("\nexecuting:\n" + chain.to_s + ":\n\n");

        value = nil

        applicators = [] of Dyad

        chain.each do |moji|
        function = Golfmoji.function(moji)

        case function.arity

            when 0
puts "Arity 0: #{function}"
                tmp = function.as(Nilad).call
puts "Temp value: " + tmp.inspect
                until applicators.empty?
                    app = applicators.pop
puts "Applying #{app} with #{value} and #{tmp}."
                    tmp = app.call(value, tmp)
puts "Temp value: " + tmp.inspect
                end

                value = tmp

            when 1
puts "Applying #{function} with #{value}."
                tmp = function.as(Monad).call(value)
puts "Temp value: " + tmp.inspect
                until applicators.empty?
                    app = applicators.pop
puts "Applying #{app} with #{value} and #{tmp}."
                    tmp = app.call(value, tmp)
puts "Temp value: " + tmp.inspect
                end

                value = tmp

            else
puts "Adding applicator #{function}"
                applicators << function.as(Dyad)

            end

        end

        value

    end

    def self.exec(src)
        src.each { |chain|
            Golfmoji.last_chain = exec_chain(chain)
        }
        Golfmoji.last_chain
    end
end
