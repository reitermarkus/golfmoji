def fib(n)
  # if n == 0
  #	[0]
  # elsif n == 1
  #	[0, 1]
  # else
  #	f = fib(n - 1)
  #	e = f[(f.size - 2)...f.size]
  #	f << (e[0] + e[1])
  # end
  if n.zero?
    [0]
  elsif n == 1
    [0, 1]
  else
    fibs = [0, 1]
    (n - 1).times do
      s = fibs.size
      fibs << (fibs[s - 2] + fibs[s - 1])
    end
    fibs
  end
end

def isfib(n)
  !(fib(n + 2) & [n]).empty?
end
