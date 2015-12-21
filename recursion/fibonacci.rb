def fib(n)
	past = 0
	present = 1
	future = 0
	
	n.times do
		past, present = present, future
		future = past + present
	end
	return future
end

def fibs_rec(n)
	case n
		when 0 then return 0
		when 1 then return 1
		else
			fibs_rec(n-2) + fibs_rec(n-1)
	end
end

fibs(13) 	# => 233
fibs_rec(13)	# => 233
