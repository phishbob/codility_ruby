#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
include Test::Unit::Assertions

# An integer N is given, representing the area of some rectangle.

# The area of a rectangle whose sides are of length A and B is A * B, and the perimeter is 2 * (A + B).

# The goal is to find the minimal perimeter of any rectangle whose area equals N. The sides of this
# rectangle should be only integers.

# For example, given integer N = 30, rectangles of area 30 are:

# (1, 30), with a perimeter of 62,
# (2, 15), with a perimeter of 34,
# (3, 10), with a perimeter of 26,
# (5, 6), with a perimeter of 22.
# Write a function:

# def solution(n)
# that, given an integer N, returns the minimal perimeter of any rectangle whose area is exactly equal to N.

# For example, given an integer N = 30, the function should return 22, as explained above.

# Write an efficient algorithm for the following assumptions:

# N is an integer within the range [1..1,000,000,000].

N_MIN = 1
N_MAX = 1000000000

def solution(n)
	raise ArgumentError.new("n has to be integer") unless n.is_a? Integer
	raise ArgumentError.new("n has to be between #{N_MIN} and #{N_MAX}") if n < N_MIN or n > N_MAX
	#raise ArgumentError.new("n has to be 4 long") if n < 4
	#raise ArgumentError.new("n has to be even") unless n%2 == 0


	# area is n cm2 long
	minimum = nil
	for a in 1..(n/2).to_i
		b = n/a
		next unless a * b == n

		puts "for #{a}, b:#{b}"
		perimeter = (a+b)*2

		puts "perimeter: #{perimeter}"
		minimum = perimeter if minimum.nil? or minimum > perimeter
	end

	return minimum
end

puts solution(6)
puts solution(30)

assert_raise(ArgumentError.new("n has to be integer")){solution(1.2)}
assert_raise(ArgumentError.new("n has to be integer")){solution('a')}

assert_raise(ArgumentError.new("n has to be between #{N_MIN} and #{N_MAX}")) {solution(-1)}
assert_raise(ArgumentError.new("n has to be between #{N_MIN} and #{N_MAX}")) {solution(N_MAX+1)}
assert_raise(ArgumentError.new("n has to be between #{N_MIN} and #{N_MAX}")) {solution(N_MIN-1)}

#assert_raise(ArgumentError.new("n has to be 4 long")) {solution(3)}
#assert_raise(ArgumentError.new("n has to be even")) {solution(5)}