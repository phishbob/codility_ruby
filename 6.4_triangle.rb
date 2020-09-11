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
MIN_VAL = -2147483648
MAX_VAL = 2147483647

def solution_brute_and_slow(a)
	raise ArgumentError.new("a has to be array smaller than #{A_MAX}") if !a.is_a?(Array) && a.length > A_MAX

	return 0 if a.length < 3
	len = a.length
	a[0...len-2].each_index do |i|
		if !a[i].is_a? Integer or a[i] < MIN_VAL or a[i] > MAX_VAL
			raise ArgumentError.new("values have to be integers between #{MIN_VAL} and #{MAX_VAL}")
		end

		(i+1...len-1).each do |j|
			jidx = i+1+j

			(j+1...len).each do |k|
					kidx = k+1+j
					# A[i] + A[j] > A[k],
					# A[j] + A[k] > A[i],
					# A[k] + A[i] > A[j].
					return 1 if is_triangle(a[i] , a[j], a[k])
					#return 1 if a[i] + a[j] > a[k] && a[j] + a[k] > a[i] && a[k] + a[i] > a[j]
			end
		end
	end
	return 0
	# 0 ≤ P < Q < R < N
end


def solution(a)
	raise ArgumentError.new("a has to be array smaller than #{A_MAX}") if !a.is_a?(Array) && a.length > A_MAX
	return 0 if a.length < 3
	a.sort!
	a[a.length-3..a.length].each_index do |i|
		if !a[i].is_a? Integer or a[i] < MIN_VAL or a[i] > MAX_VAL
			raise ArgumentError.new("values have to be integers between #{MIN_VAL} and #{MAX_VAL}")
		end
	end

	a[0...a.length-2].each_index do |i|
		if !a[i].is_a? Integer or a[i] < MIN_VAL or a[i] > MAX_VAL
			raise ArgumentError.new("values have to be integers between #{MIN_VAL} and #{MAX_VAL}")
		end
		return 1 if is_triangle(a[i], a[i+1], a[i+2])
	end
	return 0
end


def is_triangle(p,q,r)
	return true if p+q > r && q+r > p && r+p > q
	return false
end


assert_equal(1, solution([1,10,4,5,7,7,8]))
assert_equal(1,solution([1,2,3,4]))
assert_equal(0, solution([1,2]))

assert_raise(ArgumentError.new("values have to be integers between #{MIN_VAL} and #{MAX_VAL}")){solution([1,MIN_VAL-1,2])}
assert_raise(ArgumentError.new("values have to be integers between #{MIN_VAL} and #{MAX_VAL}")){solution([1,MAX_VAL+1,2])}

assert_raise(ArgumentError.new("a must be array")) {solution(1)}
arr = Array.new(A_MAX+1, 1)
#(0..A_MAX).each {|val| arr.push(1)}
assert_raise(ArgumentError.new("a length must be between #{A_MIN} and #{A_MAX}")){solution(arr)}
assert_raise(ArgumentError.new("a elements have to be integers between #{MIN_VAL}..#{MAX_VAL}")){solution([1,2,'a',3])}
assert_raise(ArgumentError.new("a elements have to be integers between #{MIN_VAL}..#{MAX_VAL}")){solution([1,MIN_VAL-1,2])}
assert_raise(ArgumentError.new("a elements have to be integers between #{MIN_VAL}..#{MAX_VAL}")){solution([1,MAX_VAL+1,2])}
