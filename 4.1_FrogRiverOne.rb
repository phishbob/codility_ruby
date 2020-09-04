#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
include Test::Unit::Assertions

# score 100%

# A small frog wants to get to the other side of a river. The frog is initially located on one bank of the river
#(position 0) and wants to get to the opposite bank (position X+1). Leaves fall from a tree onto the surface of the
# river.
# You are given an array A consisting of N integers representing the falling leaves. A[K] represents the position
# where one leaf falls at time K, measured in seconds.
# The goal is to find the earliest time when the frog can jump to the other side of the river. The frog can cross
# only when leaves appear at every position across the river from 1 to X (that is, we want to find the earliest
# moment when all the positions from 1 to X are covered by leaves). You may assume that the speed of the current
# in the river is negligibly small, i.e. the leaves do not change their positions once they fall in the river.
# For example, you are given integer X = 5 and array A such that:

#   A[0] = 1
#   A[1] = 3
#   A[2] = 1
#   A[3] = 4
#   A[4] = 2
#   A[5] = 3
#   A[6] = 5
#   A[7] = 4
# In second 6, a leaf falls into position 5. This is the earliest time when leaves appear in every position across
# the river.

# Write a function:

# class Solution { public int solution(int X, int[] A); }
# that, given a non-empty array A consisting of N integers and integer X, returns the earliest time when the frog
# can jump to the other side of the river.

# If the frog is never able to jump to the other side of the river, the function should return −1.

# For example, given X = 5 and array A such that:

#   A[0] = 1
#   A[1] = 3
#   A[2] = 1
#   A[3] = 4
#   A[4] = 2
#   A[5] = 3
#   A[6] = 5
#   A[7] = 4
# the function should return 6, as explained above.

# Write an efficient algorithm for the following assumptions:

# N and X are integers within the range [1..100,000];
# each element of array A is an integer within the range [1..X].

RANGE_INT_MIN = 1
RANGE_INT_MAX = 100000

def solution(x,a)
	raise ArgumentError.new("a needs to be an non empty array") unless a.is_a? Array and !a.empty?
	raise ArgumentError.new("a needs to be an smaller than #{RANGE_INT_MAX}") if a.length > RANGE_INT_MAX
	raise ArgumentError.new("x out of bounds") if x < RANGE_INT_MIN or x > RANGE_INT_MAX

	my_hash = {}
	#(1..x).each{ |i| my_hash[i]=i}

	#puts my_hash.inspect

	a.each_with_index do |val, idx|
		raise ArgumentError.new("a values out of bounds") if val < RANGE_INT_MIN or val > x

		my_hash[val] = true
		#puts "val: #{val}, index: #{idx} --> #{my_hash[val]}"
		#my_hash.delete val unless my_hash[val].nil?
		return idx if my_hash.length == x
	end

	#puts "my_hash = #{my_hash}"
	return -1
end

puts solution(5,[1,2,4,5,3])
puts solution(4,[1,3,2,3,4])

#arr = Array.new(RANGE_INT_MAX) { |i| i+1 }
#puts arr.inspect
#puts "#{arr.first} ,  #{arr.last}"
#puts solution(RANGE_INT_MAX, arr)
## fail
assert_raise(ArgumentError.new("a needs to be an non empty array")) {solution(1,1)}
assert_raise(ArgumentError.new("a needs to be an non empty array")) {solution(1,[])}
assert_raise(ArgumentError.new("x out of bounds")) {solution(RANGE_INT_MIN-1,[1,2])}
assert_raise(ArgumentError.new("x out of bounds")) {solution(RANGE_INT_MAX+1,[1,2])}
assert_raise(ArgumentError.new("a values out of bounds")) {solution(4,[1,RANGE_INT_MAX+1,2])}
assert_raise(ArgumentError.new("a values out of bounds")) {solution(4,[1,RANGE_INT_MIN-1,2])}

# ## success
# assert_equal(3,solution(4,[1,2,4,3,3,5]))
# assert_equal(-1,solution(7,[1,2,3,4,5]))
# assert_equal(99999, solution(RANGE_INT_MAX, Array.new(RANGE_INT_MAX) { |i| i+1 }))