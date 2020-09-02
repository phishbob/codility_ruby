#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
include Test::Unit::Assertions


# Write a function

# def solution(a)
# that, given an array A consisting of N integers, returns the number of distinct values in array A.

# For example, given array A consisting of six elements such that:

#  A[0] = 2    A[1] = 1    A[2] = 1
#  A[3] = 2    A[4] = 3    A[5] = 1
# the function should return 3, because there are 3 distinct values appearing in array A, namely 1, 2 and 3.

# Write an efficient algorithm for the following assumptions:

# N is an integer within the range [0..100,000];
# each element of array A is an integer within the range [−1,000,000..1,000,000].


A_MIN = 0
A_MAX = 100000
MIN_VAL = -1000000
MAX_VAL = 1000000


def solution(a)
	raise ArgumentError.new("a must be array") if !a.is_a? Array
	raise ArgumentError.new("a length must be betwee #{A_MIN} and #{A_MAX}") if a.length > A_MAX
	a.each do |elem|
		if !elem.is_a? Integer or elem < MIN_VAL or elem > MAX_VAL
			raise ArgumentError.new("a elements have to be integers between #{MIN_VAL}..#{MAX_VAL}")
		end
	end
	hash = Hash.new
	a.each do |elem|
		hash[elem] = true
	end

	return hash.length
end

puts solution([1,2,3])
puts solution([1,2,0,2])
puts solution([])
puts solution [-2,-1,1,2,2,-2]
assert_raise(ArgumentError.new("a must be array")) {solution(1)}
arr = Array.new
(0..A_MAX).each {|val| arr.push(1)}
assert_raise(ArgumentError.new("a length must be betwee #{A_MIN} and #{A_MAX}")){solution(arr)}
assert_raise(ArgumentError.new("a elements have to be integers between #{MIN_VAL}..#{MAX_VAL}")){solution([1,2,'a',3])}
assert_raise(ArgumentError.new("a elements have to be integers between #{MIN_VAL}..#{MAX_VAL}")){solution([1,MIN_VAL-1,2])}
assert_raise(ArgumentError.new("a elements have to be integers between #{MIN_VAL}..#{MAX_VAL}")){solution([1,MAX_VAL+1,2])}
