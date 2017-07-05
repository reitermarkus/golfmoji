# frozen_string_literal: true

require 'delegate'

module Golfmoji
  class Stack < DelegateClass(Array)
    def initialize(*args)
      super(Array.new(*args))
    end

    alias top last
  end
end
