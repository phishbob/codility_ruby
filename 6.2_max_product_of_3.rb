#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
include Test::Unit::Assertions

# this solution should be 100% - last one was 88%
#  my last solution fucks up with longer arrays with only negative numbers

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

	a_min = Array.new # values below zero
	a_neg_big = Array.new
	a_max = Array.new # values above zero

	a.each do |elem|
		if !elem.is_a? Integer or elem < MIN_VAL or elem > MAX_VAL
			raise ArgumentError.new("a elements have to be integers between #{MIN_VAL}..#{MAX_VAL}")
		end

		if elem >= 0
			if a_max.length < 3
				a_max.push(elem)
			elsif a_max.any? {|e| e < elem} # we have at least one smallert item in our array
				a_max.sort!.shift # pop smallest element
				a_max.push(elem)
			end
		elsif elem < 0
			if a_min.length < 3
				a_min.push(elem)
			elsif a_min.any? {|e| e > elem} # we have at least one bigger item in our array -  values < 0
				a_min.sort!.pop # pop biggest element
				a_min.push(elem)
			end

			## fill array with smaller negatives
			if a_neg_big.length < 3
				a_neg_big.push(elem)
			elsif a_neg_big.any? {|e| e < elem} # we have at least one smallert item in our array
				a_neg_big.sort!.shift # pop smallest element
				a_neg_big.push(elem)
			end
		end
	end

	neg_min = nil
	if a_neg_big.length == 3
		neg_min = a_neg_big[0] * a_neg_big[1] * a_neg_big[2]
	end

	a_result = a_max + a_min
	max_val = nil
	a_result[0..-3].each_index do |i|
		a_result[0..-2].each_index do |i2|
			next if i2 <= i
			tmp = a_result[i]*a_result[i2]
			a_result[0..-1].each_index do |i3|
				next if i3 <= i2
				res = tmp * a_result[i3]
				if max_val.nil? or res > max_val
					max_val = res
					#puts "#{a_result[i]} * #{a_result[i2]} * #{a_result[3]} = #{max_val}"
				end
			end
		end
	end

	max_val = neg_min if !neg_min.nil? && neg_min > max_val


	return max_val
end

puts solution([-5, -6, -4, -7, -10])

assert_equal(6, solution([1,2,3]))
assert_equal(0, solution([1,2,0]))
assert_equal(-80, solution([-10,-2,-4]))
assert_equal(120, solution([-4, -6, 3, 4, 5]))

arr = Array.new(100000) { rand(-2..1)  }
assert_equal(4, solution(arr))

arr = Array.new(100000) { rand(0..950)  }
arr[100] = 1000
arr[10000] = 1000
arr[99999] = 1000
assert_equal(1000000000, solution(arr))
assert_equal(0,solution([0,0,0,0]))
assert_equal(0, solution([1,2,0,0]))

# puts solution([1,3,-1])

assert_equal(48,solution([1,2,3,1,-3,-4,4]))

# assert_raise(ArgumentError.new("a must be array")) {solution(1)}
# arr = Array.new
# (0..A_MAX).each {|val| arr.push(1)}
# assert_raise(ArgumentError.new("a length must be between #{A_MIN} and #{A_MAX}")){solution([1,2])}
# assert_raise(ArgumentError.new("a length must be between #{A_MIN} and #{A_MAX}")){solution(arr)}
# assert_raise(ArgumentError.new("a elements have to be integers between #{MIN_VAL}..#{MAX_VAL}")){solution([1,2,'a',3])}
# assert_raise(ArgumentError.new("a elements have to be integers between #{MIN_VAL}..#{MAX_VAL}")){solution([1,MIN_VAL-1,2])}
# assert_raise(ArgumentError.new("a elements have to be integers between #{MIN_VAL}..#{MAX_VAL}")){solution([1,MAX_VAL+1,2])}
