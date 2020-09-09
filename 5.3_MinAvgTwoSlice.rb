#!/Users/patrick/.rbenv/shims/ruby
require "test/unit/assertions"
include Test::Unit::Assertions

# score 100%

# A non-empty array A consisting of N integers is given. A pair of integers (P, Q), such that 0 ≤ P < Q < N,
# is called a slice of array A (notice that the slice contains at least two elements).
# The average of a slice (P, Q) is the sum of A[P] + A[P + 1] + ... + A[Q] divided by the length of the slice.
# To be precise, the average equals (A[P] + A[P + 1] + ... + A[Q]) / (Q − P + 1).

# For example, array A such that:

#     A[0] = 4
#     A[1] = 2
#     A[2] = 2
#     A[3] = 5
#     A[4] = 1
#     A[5] = 5
#     A[6] = 8
# contains the following example slices:

# slice (1, 2), whose average is (2 + 2) / 2 = 2;
# slice (3, 4), whose average is (5 + 1) / 2 = 3;
# slice (1, 4), whose average is (2 + 2 + 5 + 1) / 4 = 2.5.
# The goal is to find the starting position of a slice whose average is minimal.

# Write a function:

# def solution(a)
# that, given a non-empty array A consisting of N integers, returns the starting position of the slice with the minimal average.
# If there is more than one slice with a minimal average, you should return the smallest starting position of such a slice.

# For example, given array A such that:

#     A[0] = 4
#     A[1] = 2
#     A[2] = 2
#     A[3] = 5
#     A[4] = 1
#     A[5] = 5
#     A[6] = 8
# the function should return 1, as explained above.

# Write an efficient algorithm for the following assumptions:

# N is an integer within the range [2..100,000];
# each element of array A is an integer within the range [−10,000..10,000].

A_MIN_LENGTH = 2
A_MAX_LENGTH = 100000
A_MIN = -10000
A_MAX =  10000

def solution(a)
    ## testing
    raise ArgumentError.new("a has to be non empty array with at least 2 elements") if !a.is_a? Array or a.length < 2
    raise ArgumentError.new("a length has to be less than < #{A_MAX_LENGTH}") unless a.length <= A_MAX_LENGTH
    a.each {|val|
        raise ArgumentError.new("a values have to be integers") unless val.is_a? Integer
        raise ArgumentError.new("a values have to be between #{A_MIN} and #{A_MAX}") if val < A_MIN or val > A_MAX
    }
    #a_sort = a.sort
    #raise ArgumentError.new("a values have to be between #{A_MIN} and #{A_MAX}") if a_sort.first < A_MIN or a_sort.last > A_MAX

    ## coding

    #a_length = a.length
    min_start_slice = nil
    min_avg = nil
    a_length = a.length

    (0...a.length-1).each do |i|
        last_val = a[i+1]
        min2 = (a[i] + a[i+1]) / 2.0
        min3 = i < a_length-2 ? (a[i] + a[i+1] + a[i+2]) / 3.0  : nil
        local_min = nil
        local_min =     (!min3.nil? && min3 < min2) ? min3 : min2
        #puts "local_min : #{local_min}"
        if min_avg.nil? or local_min < min_avg
            min_avg = local_min
            min_start_slice = i
        end

    end


    #puts "min average = #{min_avg}, starting at #{min_start_slice}"
    return min_start_slice
end

assert_equal(4,solution([1,3,3,4,1,2]))
assert_equal(1, solution([4,2,2,5,1,5,8]))
assert_equal(1, solution([-6,-8,-10,1,2]))
assert_equal(0, solution([-1, 1, -1, 1, -1]))
assert_equal(0, solution([-8, -6, -10,1,23]))

arr = Array.new(A_MAX_LENGTH) { rand(-10000...10000) }
arr[A_MAX_LENGTH-1] = -10000
arr[A_MAX_LENGTH-2] = -10000
#puts arr.length
assert_equal(99998, solution(arr))


assert_raise(ArgumentError.new("wrong number of arguments (given 0, expected 1)")) {solution()}
assert_raise(ArgumentError.new("a has to be non empty array with at least 2 elements")) {solution(1)}
assert_raise(ArgumentError.new("a has to be non empty array with at least 2 elements")) {solution([1])}
arr = Array.new
(0..A_MAX_LENGTH).each {|val| arr.push(val)}
assert_raise(ArgumentError.new("a length has to be less than < #{A_MAX_LENGTH}")) {solution(arr)}
assert_raise(ArgumentError.new("a values have to be between #{A_MIN} and #{A_MAX}")) {solution([1,A_MIN-1])}
assert_raise(ArgumentError.new("a values have to be between #{A_MIN} and #{A_MAX}")) {solution([1,A_MAX+1,2])}
assert_raise(ArgumentError.new("a values have to be integers")) {solution([1,'a',2])}
