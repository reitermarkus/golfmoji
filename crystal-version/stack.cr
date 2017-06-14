class Val
	def self.to_val(v)
		if v.is_a?(Int32)
			int(v)
		elsif v.is_a?(String)
			str(v)
		elsif v.is_a?(Array)
			arr(v.map {|e| Val.to_val(e)})
		elsif v.is_a?(Val)
			v
		else
			nill
		end
	end

	def is_a(t)
		false
	end
end

macro val(v)
	Val.to_val({{v}})
end

class NilVal < Val
	def to_s(io)
		io << "nil"
	end

	def inspect(io)
		to_s(io)
	end
end

macro nill
	NilVal.new.as(Val)
end

class IntVal < Val
	@v : Int32

	def initialize(@v)
	end

	def to_s(io)
		io << @v.to_s
	end

	def inspect(io)
		to_s(io)
	end
end

macro int(val)
	IntVal.new({{val}}).as(Val)
end

class StringVal < Val
	@v : String

	def initialize(@v)
	end

	def to_s(io)
		io << '"' + @v.to_s + '"'
	end

	def inspect(io)
		to_s(io)
	end
end

macro str(val)
	StringVal.new({{val}}).as(Val)
end

class ArrVal < Val
	@v : Array(Val)

	def initialize(@v)
	end

	def arr
		@v
	end

	def zip(v : Val)
		@v.zip(v.arr).map {|e| p e.to_a}
	end

	def inspect(io)
		io << @v.to_s
	end

	def to_s(io)
		io << @v
	end
end

macro arr(val)
	ArrVal.new({{val}}).as(Val)
end

class Functions

	@funcs = {} of Char => Proc(Val)

	def add(c, pr)
		@funcs[c] = pr
	end

	def get(c)
		@funcs[c]
	end

	def call(c)
		@funcs[c].call
	end

end

class Stack(T)

	@stack = [] of T

	def push(v)
		@stack << v
	end

	def <<(v)
		if v.is_a?(Int32)
			@stack << int(v)
		elsif v.is_a?(String)
			@stack << str(v)
		elsif v.is_a?(Array)
			@stack << arr(v.map {|e| Val.to_val(e)})
		else
			@stack << v
		end
	end

	def pop
		@stack.pop
	end

	def inspect(io)
		self.to_s(io)
	end

	def to_s(io)
		io << "\n----------\n" + @stack.join("\n") + "\n-- HEAD --\n"
	end

end

funcs = Functions.new

macro func(emoji, proc)
	funcs.add({{emoji}}, ->{{proc}})
end

func '0', { val(0) }

func '2', { val(3) }

stack = Stack(Val).new
stack << "6"
stack << 5
stack << [5, 6]

stack << ArrVal.new([int(5),int(6)]).zip(ArrVal.new([int(8),int(9)]))

p stack
