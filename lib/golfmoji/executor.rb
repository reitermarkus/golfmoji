# frozen_string_literal: true

require 'golfmoji/functions'
require 'golfmoji/stack'

require 'forwardable'

module Golfmoji
  class Executor
    extend Forwardable

    def initialize(mojis, arguments)
      @mojis = mojis
      @stack = Stack.new(arguments)
    end

    def execute
      mojis.each do |moji|
        Golfmoji.functions.fetch(moji, ->(s) { s.push moji })
                .call(stack)
      end

      stack.top(stack.size).join(' ')
    end

    private

    attr_reader :mojis, :argv, :stack
    def_delegator :stack, :top, :result
  end
end
