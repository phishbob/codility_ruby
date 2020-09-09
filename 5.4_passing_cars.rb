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
N_MAX = 100000

def solution(a)
	raise ArgumentError.new("a has to be non-empty array") if !a.is_a? Array or a.empty?
	raise ArgumentError.new("a length has to be less than #{N_MAX}") if a.length > N_MAX
	sum = 0
	ones_array = Array.new(a.length)
	reverse_index = a.length-1

	marker = 1 #a.first == 0 ? 1 : 0

	a.reverse_each do |elem|
		#puts "elem #{elem} #{elem.is_a? Integer}"
		raise ArgumentError.new("all values have to be integer") unless elem.is_a? Integer
		raise ArgumentError.new("all values have to be 0 or 1") if elem != 0 and elem != 1
		sum += 1 if elem == marker
		ones_array[reverse_index] = sum
		reverse_index -= 1
	end

	#puts "#{i} -> passing_cars: #{ones_array}"


	passing_cars = 0
	a.each_index do |i|
		next if a[i] == marker
		passing_cars += ones_array[i]
		#puts "passing_cars : #{passing_cars}, ones_array[#{i}] -> #{ones_array[i]}"
		return -1 if passing_cars > 1000000000
	end
	return passing_cars
end

# assert_equal(0,solution([0,0]))
assert_equal(0,solution([1,0]))
assert_equal(5,solution([0,1,0,1,1]))
assert_equal(3,solution([0,0,0,1]))
assert_equal(7,solution([0,1,0,1,1,1]))
assert_equal(9,solution([0,0,0,1,1,1]))
assert_equal(0, solution([1,1,1,0,0,0]))

assert_equal(-1, solution(Array.new(50000,0) + Array.new(50000,1) ))



assert_raise(ArgumentError.new("a has to be non-empty array")) { solution(1)}
assert_raise(ArgumentError.new("a has to be non-empty array")) { solution([])}
assert_raise(ArgumentError.new("all values have to be integer")) {solution([1,1,'a',0])}
assert_raise(ArgumentError.new("all values have to be integer")) {solution([1.1,0])}
arr = Array.new
(0..N_MAX).each {|val| arr.push(1)}
assert_raise(ArgumentError.new("a length has to be less than #{N_MAX}")) {solution(arr)}
assert_raise(ArgumentError.new("all values have to be 0 or 1")) {solution([1,0,2,4,5])}
