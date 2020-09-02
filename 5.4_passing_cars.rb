#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
include Test::Unit::Assertions


# A non-empty array A consisting of N integers is given. The consecutive elements of array A represent consecutive cars on a road.

# Array A contains only 0s and/or 1s:

# 0 represents a car traveling east,
# 1 represents a car traveling west.
# The goal is to count passing cars. We say that a pair of cars (P, Q), where 0 ≤ P < Q < N, is passing when P is traveling
# to the east and Q is traveling to the west.

# For example, consider array A such that:

#   A[0] = 0
#   A[1] = 1
#   A[2] = 0
#   A[3] = 1
#   A[4] = 1
# We have five pairs of passing cars: (0, 1), (0, 3), (0, 4), (2, 3), (2, 4).

# Write a function:

# def solution(a)
# that, given a non-empty array A of N integers, returns the number of pairs of passing cars.

# The function should return −1 if the number of pairs of passing cars exceeds 1,000,000,000.

# For example, given:

#   A[0] = 0
#   A[1] = 1
#   A[2] = 0
#   A[3] = 1
#   A[4] = 1
# the function should return 5, as explained above.

# Write an efficient algorithm for the following assumptions:

# N is an integer within the range [1..100,000];
# each element of array A is an integer that can have one of the following values: 0, 1.
N_MIN = 1
N_MAX = 1000000

def solution(a)
	raise ArgumentError.new("a has to be non-empty array") if !a.is_a? Array or a.empty?
	raise ArgumentError.new("a length has to be less than #{N_MAX}") if a.length > N_MAX
	a.each do |elem|
		#puts "elem #{elem} #{elem.is_a? Integer}"
		raise ArgumentError.new("all values have to be integer") unless elem.is_a? Integer
		raise ArgumentError.new("all values have to be 0 or 1") if elem != 0 and elem != 1
	end

	passing_cars = 0
	## find cars moving into direction 0
	a.each_with_index do |zero, idx|
		next unless zero == 0
		a[idx..-1].each do |one|
			next unless one == 1
			passing_cars += 1
		end
		return -1 if passing_cars > 1000000000
	end
	passing_cars = -1 if passing_cars > 1000000000
	return passing_cars
end

puts solution([0,1,0,1,1])
puts solution([0,0,0,1])
puts solution([0,1,0,1,1,1])
puts solution([0,0,0,1,1,1])

arr_a  = Array.new((N_MAX/2)-1 ,0  )
arr_b  = Array.new((N_MAX/2)-1 ,1  )
puts solution(arr_a+arr_b)


assert_raise(ArgumentError.new("a has to be non-empty array")) { solution(1)}
assert_raise(ArgumentError.new("a has to be non-empty array")) { solution([])}
assert_raise(ArgumentError.new("all values have to be integer")) {solution([1,1,'a',0])}
assert_raise(ArgumentError.new("all values have to be integer")) {solution([1.1,0])}
arr = Array.new
(0..N_MAX).each {|val| arr.push(1)}
assert_raise(ArgumentError.new("a length has to be less than #{N_MAX}")) {solution(arr)}
assert_raise(ArgumentError.new("all values have to be 0 or 1")) {solution([1,0,2,4,5])}
