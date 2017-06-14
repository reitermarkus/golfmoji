module Golfmoji

	FUNCTIONS = {}

	def self.add_function(moji, func)
		FUNCTIONS[moji] = func
	end

	def self.exec(moji)
		FUNCTIONS[moji].call
	end

	add_function("⛳", ->{ "Hello World!" })

	p exec("⛳")

end
