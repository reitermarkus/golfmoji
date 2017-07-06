# frozen_string_literal: true

require 'forwardable'

module Golfmoji
  class Stack
    extend Forwardable

    def initialize(*args)
      @stack = Array(*args)
    end

    def_delegator :@stack, :push
    def_delegator :@stack, :pop
    def_delegator :@stack, :last, :top
  end
end
