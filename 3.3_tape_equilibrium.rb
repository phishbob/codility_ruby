#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
include Test::Unit::Assertions

N_RANGE_MIN = 2
 N_RANGE_MAX =100000
ELEMENT_RANGE_MIN = -1000
ELEMENT_RANGE_MAX =  1000


# A non-empty array A consisting of N integers is given. Array A represents numbers on a tape.
# Any integer P, such that 0 < P < N, splits this tape into two non-empty parts: A[0], A[1],
# ..., A[P − 1] and A[P], A[P + 1], ..., A[N − 1].
# The difference between the two parts is the value of:
# |(A[0] + A[1] + ... + A[P − 1]) − (A[P] + A[P + 1] + ... + A[N − 1])|
# In other words, it is the absolute difference between the sum of the first part and the sum of
# the second part.
#
# For example, consider array A such that:

#   A[0] = 3 #   A[1] = 1 #   A[2] = 2 #   A[3] = 4 #   A[4] = 3 # We can split
# this tape in four places:
# 	P = 1, difference = |3 − 10| = 7
# 	P = 2, difference = |4 − 9| = 5
# 	P = 3, difference = |6 − 7| = 1
# 	P = 4, difference = |10 − 3| = 7
# Write a function:

# class Solution { public int solution(int[] A); }
# that, given a non-empty array A of N integers, returns the minimal difference that can be achieved.

# For example, given:

#   A[0] = 3
#   A[1] = 1
#   A[2] = 2
#   A[3] = 4
#   A[4] = 3
# the function should return 1, as explained above.

# Write an efficient algorithm for the following assumptions:

# N is an integer within the range [2..100,000];
# each element of array A is an integer within the range [−1,000..1,000].


def solution(a)
    # Minimize the value |(A[0] + ... + A[P-1]) = (A[P] + ... + A[N-1])|.
    # :param A: non-empty list of integers
    # :return: an integer - the index value where the smallest difference occurs
    # array must be more than 2 elements

    raise ArgumentError.new("a needs to be array") if !a.is_a? Array
    raise ArgumentError.new("a has to have  >= 2 elements") if a.length < 2
    raise ArgumentError.new("a has to have  <=  100000 elements") if a.length > 100000
    a_sort = a.sort
    #puts "a min = #{a_sort.first}, a max = #{a_sort.last}"
    raise ArgumentError.new("elements of array have to be between -1000 and 1000") if a_sort.first < ELEMENT_RANGE_MIN or a_sort.last > ELEMENT_RANGE_MAX

    l = a.length
    min = nil

    # get the split mark
    for split in 1..l-1 do
    	#puts "split array at position #{split}"

    	low = 0
    	high = 0
    	a.each_with_index do |val, index|
    		if index < split
	    		low = low + val
	    	else
	    		high = high + val
	    	end
    	end
    	diff = (low - high).abs
    	#puts "diff = #{diff}"
    	min = diff if min == nil or min > diff
    end

    return min
end

## fail
assert_raise(ArgumentError.new("a needs to be array")) {solution(1)}
assert_raise(ArgumentError.new("a has to have  >= 2 elements")) {solution([1])}
assert_raise(ArgumentError.new("elements of array have to be between -1000 and 1000")) {solution([1,2,-1001])}
assert_raise(ArgumentError.new("elements of array have to be between -1000 and 1000")) {solution([1001, 1,2, -1000])}
a = Array.new
(0..N_RANGE_MAX).each{ a.push(rand(-1000..1000)) }
assert_raise(ArgumentError.new("a has to have  <=  100000 elements")) {solution(a)}
## success
assert_equal(2,solution([1,2,5]))
assert_equal(1000,solution([-1000, -900, -200, 100, 1000]))
assert_equal(1,solution([3,1,2,4,3]))


