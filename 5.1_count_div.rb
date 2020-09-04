#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
include Test::Unit::Assertions


# score 23 %  - this is crap +

# Write a function:

# def solution(a, b, k)
# that, given three integers A, B and K, returns the number of integers within the range [A..B] that are divisible by K, i.e.:

# { i : A ≤ i ≤ B, i mod K = 0 }
# For example, for A = 6, B = 11 and K = 2, your function should return 3, because there are three numbers divisible by 2 within
# the range [6..11], namely 6, 8 and 10.

# Write an efficient algorithm for the following assumptions:

# A and B are integers within the range [0..2,000,000,000];
# K is an integer within the range [1..2,000,000,000];
# A ≤ B.

MAX_VAL = 2000000000
MIN_VAL = 0
K_MIN_VAL = 1

def solution(a,b,k)
	raise ArgumentError.new("a has to be between #{MIN_VAL} and #{MAX_VAL}") if a < MIN_VAL or a > MAX_VAL
	raise ArgumentError.new("b has to be between #{MIN_VAL} and #{MAX_VAL}") if b < MIN_VAL or b > MAX_VAL
	raise ArgumentError.new("a <= b") if a > b
	raise ArgumentError.new("k has to be between #{K_MIN_VAL} and #{MAX_VAL}") if k < K_MIN_VAL or k > MAX_VAL





	first_divider = 0
	a = 1 if a < 1
	(a..b).each do |elem|
		if elem%k == 0
			first_divider = elem
			break
		end
	end

	puts "first_divider: #{first_divider}"

	counter = 0
	if first_divider > 0
		#puts "first_divider = #{first_divider}, b = #{b}, step = #{k}"
		(first_divider..b).step(k).each do |e|
			counter = counter +1
		end
	end

	return counter
end

# puts solution(0,1,11)
# puts solution(10,10,5)
# puts solution(10,10,7)
# puts solution(10,10,20)


#A = 10, B = 10, K in {5,7,20}

# assert_raise(ArgumentError.new("a has to be between #{MIN_VAL} and #{MAX_VAL}") ) {solution(MIN_VAL-1, 1, 1)}
# assert_raise(ArgumentError.new("a has to be between #{MIN_VAL} and #{MAX_VAL}") ) {solution(MAX_VAL+1, 1, 1)}
# assert_raise(ArgumentError.new("b has to be between #{MIN_VAL} and #{MAX_VAL}") ) {solution(1, MIN_VAL-1,  1)}
# assert_raise(ArgumentError.new("b has to be between #{MIN_VAL} and #{MAX_VAL}") ) {solution(1, MAX_VAL+1,  1)}
# assert_raise(ArgumentError.new("k has to be between #{K_MIN_VAL} and #{MAX_VAL}")) {solution(1,1,K_MIN_VAL-1)}
# assert_raise(ArgumentError.new("k has to be between #{K_MIN_VAL} and #{MAX_VAL}")) {solution(1,1,MAX_VAL+1)}
puts solution(6,11,2)
puts solution(MIN_VAL,MAX_VAL,127)

# assert_equal(3,solution(6,11,2))
#assert_equal(15748032,solution(MIN_VAL,MAX_VAL,127))
# assert_equal(1, solution(1,1,1))
# assert_equal(4, solution(1,14,3))
#puts solution(6,11,2)