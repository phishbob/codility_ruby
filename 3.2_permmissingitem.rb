#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
include Test::Unit::Assertions

# score 100%

# An array A consisting of N different integers is given. The array contains integers
# in the range [1..(N + 1)],
# which means that exactly one element is missing.

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


MAX_RANGE = 100000
MIN_RANGE = 0

def solution(a)
    raise ArgumentError.new("a needs to be array") unless a.is_a? Array

    # An empty list so the missing element must be "1"
    return 1 if a.size == 0
    a_len_sum = 0
    (1..a.length+1).each {|e| a_len_sum += e}

    a_sum = 0
    a.each do |e|
      raise ArgumentError.new("elements must be integers was #{e}") if !e.is_a? Integer or e < 1 or e > a.length+1
      a_sum += e
    end

    return a_len_sum - a_sum
end

solution([1,3])
assert_raise(ArgumentError.new("a needs to be array")) {solution(0)}
assert_raise(ArgumentError.new("elements must be integers was #{1.2}")) {solution([1.2])}
assert_raise(ArgumentError.new("elements must be integers was #{0}")) {solution([0,1])}
assert_equal(2,solution([1,5,3,4]))
assert_equal(5,solution([1,2,3,4]))

arr = Array.new(MAX_RANGE) { |i| i+1 }
arr.delete_at(MAX_RANGE-10)
puts solution(arr)
puts solution([])
puts solution([1,5,3,4])
puts solution([1,2,3,4])
