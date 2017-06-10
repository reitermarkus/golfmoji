module Golfmoji
  FUNCTIONS = {} of Char => Golfmoji

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

  moji '⛳' {
    "Hello World!"
  }

  moji '🎲' {
    rand
  }

  moji '⚖', a : Comparable, b : Comparable {
    if a.is_a?(Array) && b.is_a?(Array)
      a.zip(b).map { |e| e[0] <=> e[1] }
    else
      a <=> b
    end
  }

  def self.function(moji)
    FUNCTIONS[moji]
  end
end

f = Golfmoji.function('⚖')
if f
  p f.call(5, 4)
  p f.call([5, 3, 5], [2, 4, 5])
end
