# frozen_string_literal: true

require 'unicode'

module Golfmoji
  class Lexer
    def initialize(input)
      @tokens = Unicode.text_elements(input)
      @iterator = @tokens.each
    end

    def next_token
      iterator.next
    end

    private

    attr_reader :iterator
  end
end
