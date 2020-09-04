#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
include Test::Unit::Assertions

# score 100% with N_MAX = 1.000.000.000

# A non-empty array A consisting of N integers is given.
# A permutation is a sequence containing each element from 1 to N once, and only once.
# For example, array A such that:

#     A[0] = 4
#     A[1] = 1
#     A[2] = 3
#     A[3] = 2
# is a permutation, but array A such that:

#     A[0] = 4
#     A[1] = 1
#     A[2] = 3
# is not a permutation, because value 2 is missing.

# The goal is to check whether array A is a permutation.
# Write a function:
# def solution(a)
# that, given an array A, returns 1 if array A is a permutation and 0 if it is not.

# For example, given array A such that:
#     A[0] = 4
#     A[1] = 1
#     A[2] = 3
#     A[3] = 2
# the function should return 1.

# Given array A such that:
#     A[0] = 4
#     A[1] = 1
#     A[2] = 3
# the function should return 0.

# Write an efficient algorithm for the following assumptions:
# N is an integer within the range [1..100,000];
# each element of array A is an integer within the range [1..1,000,000,000].

N_MIN = 1
N_MAX = 1000000000
A_LEN_MAX = 100000

def solution a
	raise ArgumentError.new("a has to be a non empty array") if !a.is_a? Array or a.empty?
	raise ArgumentError.new("a has to be smaller than #{A_LEN_MAX} elements") if a.length > A_LEN_MAX
	res = Hash.new

	#fill the hash
	a.each do |elem|
		raise ArgumentError.new("a values have to be between #{N_MIN} and #{N_MAX}, was #{elem}") if elem < N_MIN or elem > N_MAX
		return 0 if res[elem]
		res[elem] = elem
	end

	#return 0 if res.length != a.length

	(1..a.length).each do |i|
		next if res[i]
		return 0
	end

	return 1
end


assert_raise(ArgumentError.new("a has to be a non empty array")) {solution(1)}
assert_raise(ArgumentError.new("a has to be a non empty array")) {solution([])}
arr = Array.new(A_LEN_MAX+1){ |i| i+1  }
assert_raise(ArgumentError.new("a has to be smaller than #{A_LEN_MAX} elements")) {solution(arr)}
assert_raise(ArgumentError.new("a values have to be between #{N_MIN} and #{N_MAX}, was #{N_MIN-1}")) {solution([1,N_MIN-1])}
assert_raise(ArgumentError.new("a values have to be between #{N_MIN} and #{N_MAX}, was #{N_MAX+1}")) {solution([1,N_MAX+1,2000])}

assert_equal(0,solution([4,1,N_MAX]))
assert_equal(0,solution([4,3,N_MIN]))
assert_equal(1,solution([4,1,3,2]))
assert_equal(0,solution([4,1,3]))
assert_equal(0,solution([4,1,3,34534,345]))
assert_equal(0,solution([2,3,4]))
puts solution([4,1,3,2])
puts solution([4,1,3])
puts solution([4,1,3,1,2])
puts solution([1,1,1,1,1])



