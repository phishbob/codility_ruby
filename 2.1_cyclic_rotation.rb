#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
include Test::Unit::Assertions

# score 100%

# An array A consisting of N integers is given. Rotation of the array means that each element is shifted
# right by one index, and the last element of the array is moved to the first place. For example, the rotation of
# array A = [3, 8, 9, 7, 6] is [6, 3, 8, 9, 7] (elements are shifted right by one index and 6 is moved to the
# first place).

# The goal is to rotate array A K times; that is, each element of A will be shifted to the right K times.

# Write a function:
# 		def solution(a, k)
# that, given an array A consisting of N integers and an integer K, returns the array A rotated K times.

# For example, given

#     A = [3, 8, 9, 7, 6]
#     K = 3
# the function should return [9, 7, 6, 3, 8]. Three rotations were made:

#     [3, 8, 9, 7, 6] -> [6, 3, 8, 9, 7]
#     [6, 3, 8, 9, 7] -> [7, 6, 3, 8, 9]
#     [7, 6, 3, 8, 9] -> [9, 7, 6, 3, 8]
# For another example, given

#     A = [0, 0, 0]
#     K = 1
# the function should return [0, 0, 0]

# Given

#     A = [1, 2, 3, 4]
#     K = 4
# the function should return [1, 2, 3, 4]

# Assume that:

# N and K are integers within the range [0..100];
# each element of array A is an integer within the range [−1,000..1,000].
# In your solution, focus on correctness. The performance of your solution will not be the focus of the assessment.

# Rotate the array A by k steps
# :param A: an array of integers
# :param K: number of times to shift right
# :return: the rotated array

N_MIN = 0
N_MAX = 100
MIN_VAL = -1000
MAX_VAL = 1000

def solution(a,k)
	raise ArgumentError.new("a is no array") if !a.is_a? Array or a.length > N_MAX
	raise ArgumentError.new("k has to be set") if k.nil? or !k.is_a? Integer
	a.each do |elem|
		raise ArgumentError.new("values have to be integers between #{MIN_VAL} and #{MAX_VAL} ") if !elem.is_a? Integer or elem < MIN_VAL or elem > MAX_VAL
	end

	return a if a.empty?
	#puts "k%a.length: #{-k%a.length}"

	return a.rotate(-k%a.length)
end

Array.new(10) { |i|  }

assert_raise(ArgumentError.new("a is no array")) {solution(Array.new(N_MAX+1) { |i| i },1)}
assert_raise(ArgumentError.new("k has to be set")) {solution([],nil)}
assert_raise(ArgumentError.new("k has to be set")) {solution([],'a')}
assert_raise(ArgumentError.new("values have to be integers between #{MIN_VAL} and #{MAX_VAL} ")) {solution([MIN_VAL-1],1)}
assert_raise(ArgumentError.new("values have to be integers between #{MIN_VAL} and #{MAX_VAL} ")) {solution([MAX_VAL+1],1)}

assert_equal([9, 7, 6, 3, 8], solution([3, 8, 9, 7, 6], 3))
assert_equal([7, 6, 3, 8, 9], solution([3, 8, 9, 7, 6], 2))
assert_equal([], solution([], 3))
assert_equal([0], solution([0], 3))
assert_equal([2,3,1], solution([1,2,3], 5))
assert_equal([3,1,2], solution([1,2,3], 1))
arr = Array.new(N_MAX) { |i| i+1 }
assert_equal(arr, solution(arr, 0))

