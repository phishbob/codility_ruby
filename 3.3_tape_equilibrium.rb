#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
include Test::Unit::Assertions

# score 100%

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

A_MIN = 2
A_MAX = 100000
MIN_VAL = -1000
MAX_VAL =  1000

def solution(a)
    #puts a.inspect
    raise ArgumentError.new("a needs to be array") if !a.is_a? Array
    raise ArgumentError.new("a has to > #{A_MIN} and < #{A_MAX} elements") if a.length < A_MIN or a.length > A_MAX
    a.each do |val|
        raise ArgumentError.new("elements of array have to be between -1000 and 1000") if val < MIN_VAL or val > MAX_VAL
    end

    min = nil
    a_sum_low = 0
    a_sum_high = 0
    a.each {|i| a_sum_high += i}

    #puts "sum high: #{a_sum_high}"
    (0...a.length-1).each do |i|
      #puts "i = #{i}"
      a_sum_low += a[i]
      a_sum_high -= a[i]
      #puts "#{i} --> count: ai: #{a[i]}, a_high: #{a[a.length-1-i]}"
      #puts "         sum: low: #{a_sum_low}, high: #{a_sum_high}"
      diff = (a_sum_low - a_sum_high).abs
      min = diff if min == nil or min > diff
    end

    return min
end


puts solution([1000,-1000])
#puts solution([1,2,3])
puts solution([1,2,5,7])

puts solution([3 ,1, 2, 4, 3])
arr = Array.new(A_MAX) { |i| rand(MIN_VAL..MAX_VAL) }
puts solution(arr)
## fail
assert_raise(ArgumentError.new("a needs to be array")) {solution(1)}
assert_raise(ArgumentError.new("a has to > #{A_MIN} and < #{A_MAX} elements")) {solution([1])}
assert_raise(ArgumentError.new("a has to > #{A_MIN} and < #{A_MAX} elements")) {solution(Array.new(A_MAX+1,1))}
assert_raise(ArgumentError.new("elements of array have to be between -1000 and 1000")) {solution([1,2,-1001])}
assert_raise(ArgumentError.new("elements of array have to be between -1000 and 1000")) {solution([1001, 1,2, -1000])}

## success
assert_equal(2,solution([1,2,5]))
assert_equal(1000,solution([-1000, -900, -200, 100, 1000]))
assert_equal(1,solution([3,1,2,4,3]))


