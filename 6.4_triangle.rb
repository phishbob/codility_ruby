#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
include Test::Unit::Assertions

# An array A consisting of N integers is given. A triplet (P, Q, R) is triangular if 0 ≤ P < Q < R < N and:

# A[P] + A[Q] > A[R],
# A[Q] + A[R] > A[P],
# A[R] + A[P] > A[Q].
# For example, consider array A such that:

#   A[0] = 10    A[1] = 2    A[2] = 5
#   A[3] = 1     A[4] = 8    A[5] = 20
# Triplet (0, 2, 4) is triangular.

# Write a function:

# def solution(a)
# that, given an array A consisting of N integers, returns 1 if there exists a triangular triplet for this array and returns 0 otherwise.

# For example, given array A such that:

#   A[0] = 10    A[1] = 2    A[2] = 5
#   A[3] = 1     A[4] = 8    A[5] = 20
# the function should return 1, as explained above. Given array A such that:

#   A[0] = 10    A[1] = 50    A[2] = 5
#   A[3] = 1
# the function should return 0.

# Write an efficient algorithm for the following assumptions:

# N is an integer within the range [0..100,000];
# each element of array A is an integer within the range [−2,147,483,648..2,147,483,647].

A_MIN = 0
A_MAX = 100000
MIN_VAL = -2147483647
MAX_VAL = 2147483647

def solution(a)
	raise ArgumentError.new("a must be array") if !a.is_a? Array
	raise ArgumentError.new("a length must be between #{A_MIN} and #{A_MAX}") if a.length < A_MIN or a.length > A_MAX
	raise ArgumentError.new("a elements have to be integers between #{MIN_VAL}..#{MAX_VAL}") unless a.all? {|elem| elem.is_a? Integer }
	return 0 if a.length < 3
	a_sort = a.sort
	raise ArgumentError.new("a elements have to be integers between #{MIN_VAL}..#{MAX_VAL}") if a_sort.first < MIN_VAL or a_sort.last > MAX_VAL



	# check if if 0 ≤ P < Q < R < N and:
	a.each_with_index do |p, idx1|
		a.each_with_index do |q, idx2|
			next if idx2 <= idx1
			a.each_with_index do |r, idx3|
				next if idx3 <= idx2

				# A[P] + A[Q] > A[R],
				# A[Q] + A[R] > A[P],
				# A[R] + A[P] > A[Q].
				return 1 if p + q > r && q+r > p && r+p >q
			end
		end
	end

	return 0
end

puts solution([1])
puts solution([1,10,4,5,7,7,8])
puts solution([10,50,5,1])

assert_raise(ArgumentError.new("a must be array")) {solution(1)}
arr = Array.new(A_MAX+1, 1)
#(0..A_MAX).each {|val| arr.push(1)}
assert_raise(ArgumentError.new("a length must be between #{A_MIN} and #{A_MAX}")){solution(arr)}
assert_raise(ArgumentError.new("a elements have to be integers between #{MIN_VAL}..#{MAX_VAL}")){solution([1,2,'a',3])}
assert_raise(ArgumentError.new("a elements have to be integers between #{MIN_VAL}..#{MAX_VAL}")){solution([1,MIN_VAL-1,2])}
assert_raise(ArgumentError.new("a elements have to be integers between #{MIN_VAL}..#{MAX_VAL}")){solution([1,MAX_VAL+1,2])}
