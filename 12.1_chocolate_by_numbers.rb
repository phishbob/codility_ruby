#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
include Test::Unit::Assertions

# Two positive integers N and M are given. Integer N represents the number of chocolates arranged in a circle,
#numbered from 0 to N − 1.

# You start to eat the chocolates. After eating a chocolate you leave only a wrapper.

# You begin with eating chocolate number 0. Then you omit the next M − 1 chocolates or wrappers on the circle,
# and eat the following one.

# More precisely, if you ate chocolate number X, then you will next eat the chocolate with number (X + M)
# modulo N (remainder of division).

# You stop eating when you encounter an empty wrapper.

# For example, given integers N = 10 and M = 4. You will eat the following chocolates: 0, 4, 8, 2, 6.

# The goal is to count the number of chocolates that you will eat, following the above rules.

# Write a function:

# class Solution { public int solution(int N, int M); }
# that, given two positive integers N and M, returns the number of chocolates that you will eat.

# For example, given integers N = 10 and M = 4. the function should return 5, as explained above.

# Write an efficient algorithm for the following assumptions:

# N and M are integers within the range [1..1,000,000,000].

N_MIN = 1
N_MAX = 1000000000



def solution(n,m)
	raise ArgumentError.new("n has to be positive Integer between #{N_MIN} and #{N_MAX}") if !n.is_a? Integer or n < N_MIN or n > N_MAX
	raise ArgumentError.new("m has to be positive Integer between #{N_MIN} and #{N_MAX}") if !m.is_a? Integer or m < N_MIN or m > N_MAX

	ret = n / greatest_common_divisor(n,m)
	return ret
end

def greatest_common_divisor(a,b)
	return b if a % b == 0
	return greatest_common_divisor(b, a%b)
end
# def solution(n,m)
# 	raise ArgumentError.new("n has to be positive Integer between #{N_MIN} and #{N_MAX}") if !n.is_a? Integer or n < N_MIN or n > N_MAX
# 	raise ArgumentError.new("m has to be positive Integer between #{N_MIN} and #{N_MAX}") if !m.is_a? Integer or m < N_MIN or m > N_MAX

# 	puts "n = #{n}"
# 	puts "m = #{m}"
# 	step = m
# 	choc = Array.new(n,1)
# 	offset = 0
# 	ret = 0

# 	## faster solution
# 	while choc[offset] == 1
# 		 #puts "#{ret} -> offset = #{offset}  " if ret%1000 == 0#, #{choc.inspect}"
# 		choc[offset] = 0
# 		ret += 1
# 		offset = (offset+m)%n
# 	end
# 	#puts "ret = #{ret}"
# 	return ret
# end



	## first solution
	# while true
	# 	#puts "length: #{choc.length} ->   #{choc.inspect}"
	# 	(offset...choc.length).step(m).each do |i|
	# 		if choc[i] == 1
	# 			#puts "*** index:#{i} -> c: #{choc[i]} "
	# 			#puts "*** we ate chocolate number #{i}"
	# 			choc[i] = 0
	# 			offset = i
	# 			ret += 1
	# 		else
	# 			puts choc.inspect unless choc.length > 100
	# 			puts "END -> we ate #{ret} chocolates"
	# 			return ret
	# 		end # if else
	# 	end # each
	# 	#puts "old offset = #{offset}, m = #{m}, n= #{n}"
	# 	offset = (offset+m)%n
	# 	#puts "new offset = #{offset}"
	# end # while
#end

puts solution((3**9)*(2**14),(2**14)*(2**14))
#puts solution(N_MAX, N_MIN)
# puts solution(10000000,12)
puts solution(12,3)
puts solution(10,4)

assert_raise(ArgumentError.new("n has to be positive Integer between #{N_MIN} and #{N_MAX}")){solution(N_MIN-1, N_MIN)}
assert_raise(ArgumentError.new("n has to be positive Integer between #{N_MIN} and #{N_MAX}")){solution(N_MAX+11, N_MIN)}
assert_raise(ArgumentError.new("n has to be positive Integer between #{N_MIN} and #{N_MAX}")){solution(1.2, N_MIN)}
assert_raise(ArgumentError.new("m has to be positive Integer between #{N_MIN} and #{N_MAX}")){solution(N_MIN, N_MIN-1)}
assert_raise(ArgumentError.new("m has to be positive Integer between #{N_MIN} and #{N_MAX}")){solution(N_MAX, N_MAX+1)}
assert_raise(ArgumentError.new("m has to be positive Integer between #{N_MIN} and #{N_MAX}")){solution(N_MAX, 1.2)}