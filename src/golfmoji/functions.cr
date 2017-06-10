module Golfmoji
  FUNCTIONS = {} of String => Golfmoji

  macro moji(name, *args, &block)
    class Emoji_{{name.id}}
      include Golfmoji

      def arity
        {{ args.size }}
      end

      {% if args.size == 0 %}
        def call(*ignored)
          {{block.body}}
        end
      {% else %}
        def call({{*args}}, *ignored)
          {{block.body}}
        end
      {% end %}

      def moji
        {{name}}
      end
    end

    FUNCTIONS[{{name}}] = Emoji_{{name.id}}.new.as(Golfmoji)
  end

  moji "⛳" {
    "Hello World!"
  }

  moji "🎲" {
    rand
  }

  moji "⚖", a : Comparable, b : Comparable {
    if a.is_a?(Array) && b.is_a?(Array)
      a.zip(b).map { |e| e[0] <=> e[1] }
    else
      a <=> b
    end
  }

  moji "0️⃣" {  0 }
  moji "1️⃣" {  1 }
  moji "2️⃣" {  2 }
  moji "3️⃣" {  3 }
  moji "4️⃣" {  4 }
  moji "5️⃣" {  5 }
  moji "6️⃣" {  6 }
  moji "7️⃣" {  7 }
  moji "8️⃣" {  8 }
  moji "9️⃣" {  9 }
  moji "🔟" { 10 }

  def self.function(moji)
    FUNCTIONS[moji]
  end
end

f = Golfmoji.function("⚖")
if f
  p f.call(5, 4)
  p f.call([5, 3, 5], [2, 4, 5])
end
