module Golfmoji

	FUNCTIONS = {}
	STACK = []

	def self.put(val)
		STACK << val
	end

	def self.peek
		STACK.last
	end

	def self.pop
		STACK.pop
	end

	def self.add_function(moji, func)
		FUNCTIONS[moji] = func
	end

	def self.exec(moji)
		FUNCTIONS[moji].call(Golfmoji)
	end

	add_function("⛳", ->(s) { s.put "Hello World!" })
	add_function("💥", ->(s) { s.put s.pop.chars })
	add_function("©", ->(s) { s.put s.peek })
	add_function("🎗", ->(s) { s.put s.pop.zip(s.pop) })

	["⛳", "💥", "📝", "🎗"].each do |f|
		exec(f)
	end

	p "result:"
	p peek

end
