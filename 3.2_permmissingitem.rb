#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
include Test::Unit::Assertions


MAX_RANGE = 100000
MIN_RANGE = 0

# An array A consisting of N different integers is given. The array contains integers in the range [1..(N + 1)], which means that exactly one element is missing.

# Your goal is to find that missing element.

# Write a function:

# class Solution { public int solution(int[] A); }
# that, given an array A, returns the value of the missing element.

# For example, given array A such that:

#   A[0] = 2
#   A[1] = 3
#   A[2] = 1
#   A[3] = 5
# the function should return 4, as it is the missing element.

# Write an efficient algorithm for the following assumptions:

# N is an integer within the range [0..100,000];
# the elements of A are all distinct;
# each element of array A is an integer within the range [1..(N + 1)].


def solution(a)
    """
    Find the missing element in a given permutation
    :param A: list of integers
    :return: the integer that is missing in O(n) time and O(1) space complexity
    """
    raise ArgumentError.new("a needs to be array") unless a.is_a? Array

    # An empty list so the missing element must be "1"
    return 1 if a.size == 0

    ## missing element in the array
    #a.sort!
    last = nil
    #puts "a = #{a}"
    #puts "a.sort = #{a.sort}"
    a.sort.each do |elem|
    	#puts "elem is #{elem}"
    	if  !last.nil? &&  last +1  == elem
    		last = elem
    	elsif last.nil?
    			last = elem
    	else # break in the permutation
    		return last +1
    	end
    end # each

    return a.sort.last+1
end


assert_raise(ArgumentError.new("a needs to be array")) {solution(0)}
puts solution([])
puts "===> #{solution([1,5,3,4])}"
puts "===> #{solution([1,2,3,4])}"
