#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
include Test::Unit::Assertions


# A non-empty array A consisting of N integers is given. The product of triplet (P, Q, R) equates to A[P] * A[Q] * A[R] (0 ≤ P < Q < R < N).

# For example, array A such that:

#   A[0] = -3
#   A[1] = 1
#   A[2] = 2
#   A[3] = -2
#   A[4] = 5
#   A[5] = 6
# contains the following example triplets:

# (0, 1, 2), product is −3 * 1 * 2 = −6
# (1, 2, 4), product is 1 * 2 * 5 = 10
# (2, 4, 5), product is 2 * 5 * 6 = 60
# Your goal is to find the maximal product of any triplet.

# Write a function:

# def solution(a)
# that, given a non-empty array A, returns the value of the maximal product of any triplet.

# For example, given array A such that:

#   A[0] = -3
#   A[1] = 1
#   A[2] = 2
#   A[3] = -2
#   A[4] = 5
#   A[5] = 6
# the function should return 60, as the product of triplet (2, 4, 5) is maximal.

# Write an efficient algorithm for the following assumptions:

# N is an integer within the range [3..100,000];
# each element of array A is an integer within the range [−1,000..1,000].


A_MIN = 3
A_MAX = 100000
MIN_VAL = -1000
MAX_VAL = 1000


def solution(a)
	raise ArgumentError.new("a must be array") if !a.is_a? Array
	raise ArgumentError.new("a length must be between #{A_MIN} and #{A_MAX}") if a.length < A_MIN or a.length > A_MAX
	a.each do |elem|
		if !elem.is_a? Integer or elem < MIN_VAL or elem > MAX_VAL
			raise ArgumentError.new("a elements have to be integers between #{MIN_VAL}..#{MAX_VAL}")
		end
	end

	max_val = nil
	a[0..-3].each_with_index do |val1,idx1|
		# get second element
		a[0..-2].each_with_index do |val2, idx2|
			next if idx2 <= idx1
			a[0..-1].each_with_index do |val3, idx3|
				next if idx3 <= idx2
				mul = val1*val2*val3
				max_val = mul if max_val.nil? or mul > max_val
			end
		end
	end

	return max_val
end

puts solution([1,2,3,1,-3,-4,4])

assert_raise(ArgumentError.new("a must be array")) {solution(1)}
arr = Array.new
(0..A_MAX).each {|val| arr.push(1)}
assert_raise(ArgumentError.new("a length must be between #{A_MIN} and #{A_MAX}")){solution([1,2])}
assert_raise(ArgumentError.new("a length must be between #{A_MIN} and #{A_MAX}")){solution(arr)}
assert_raise(ArgumentError.new("a elements have to be integers between #{MIN_VAL}..#{MAX_VAL}")){solution([1,2,'a',3])}
assert_raise(ArgumentError.new("a elements have to be integers between #{MIN_VAL}..#{MAX_VAL}")){solution([1,MIN_VAL-1,2])}
assert_raise(ArgumentError.new("a elements have to be integers between #{MIN_VAL}..#{MAX_VAL}")){solution([1,MAX_VAL+1,2])}
