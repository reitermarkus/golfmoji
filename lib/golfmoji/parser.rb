# frozen_string_literal: true

require 'golfmoji/lexer'

require 'unicode'

module Golfmoji
  class Parser
    def self.parse(input)
      new(input).parse
    end

    def initialize(input, _lexer = Lexer)
      @lexer = Lexer.new(input)
      @tokens = []
    end

    def parse
      loop do
        break unless (token = lexer.next_token)

        next if token =~ /\A\s+\Z/

        tokens << token
      end

      tokens
    end

    private

    attr_reader :lexer, :tokens
  end
end
