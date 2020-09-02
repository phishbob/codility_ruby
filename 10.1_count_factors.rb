#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
include Test::Unit::Assertions


# A positive integer D is a factor of a positive integer N if there exists an integer M such that N = D * M.

# For example, 6 is a factor of 24, because M = 4 satisfies the above condition (24 = 6 * 4).

# Write a function:

# def solution(n)
# that, given a positive integer N, returns the number of its factors.

# For example, given N = 24, the function should return 8, because 24 has 8 factors, namely 1, 2, 3, 4, 6, 8, 12, 24. There are no other factors of 24.

# Write an efficient algorithm for the following assumptions:

# N is an integer within the range [1..2,147,483,647].

N_MIN = 1
N_MAX = 2147483647
def solution(n)


	raise ArgumentError.new("N has to be an integer between #{N_MIN} and #{N_MAX}") if !n.is_a? Integer or n < N_MIN or n > N_MAX
	a_step = n%2 == 0 ? 1 : 2
	ret = 1
	(1..n/2).step(a_step).each do |elem|
		ret += 1 if n%elem == 0
		# if n%elem == 0
		# 	puts "#{n} mod #{elem} == 0, ret = #{ret}"
		# end
	end


	return ret
end
puts solution(3)
# puts solution(28)
# puts solution(24)
# puts solution(27)
# puts solution(155)

assert_raise(ArgumentError.new("N has to be an integer between #{N_MIN} and #{N_MAX}")) {solution(1.2)}
assert_raise(ArgumentError.new("N has to be an integer between #{N_MIN} and #{N_MAX}")) {solution('a')}
assert_raise(ArgumentError.new("N has to be an integer between #{N_MIN} and #{N_MAX}")) {solution(N_MIN-1)}
assert_raise(ArgumentError.new("N has to be an integer between #{N_MIN} and #{N_MAX}")) {solution(N_MAX+1)}


