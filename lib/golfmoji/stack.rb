# frozen_string_literal: true

require 'forwardable'

module Golfmoji
  class Stack
    extend Forwardable

    def initialize(*args)
      @stack = Array(*args)
    end

    def reverse
      @stack = @stack.reverse
    end

    def clone
      Marshal.load(Marshal.dump(self))
    end

    def_delegator :@stack, :push
    def_delegator :@stack, :pop
    def_delegator :@stack, :last, :top
    def_delegator :@stack, :size
    def_delegator :@stack, :to_s
    def_delegator :@stack, :inspect
  end
end
