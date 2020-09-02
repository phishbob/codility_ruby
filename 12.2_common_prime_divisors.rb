#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
require "prime"
include Test::Unit::Assertions


# A prime is a positive integer X that has exactly two distinct divisors: 1 and X.
# The first few prime integers are 2, 3, 5, 7, 11 and 13.

# A prime D is called a prime divisor of a positive integer P if there exists a positive integer K such that D * K = P.
# For example, 2 and 5 are prime divisors of 20.

# You are given two positive integers N and M. The goal is to check whether the sets of prime divisors of integers N and M
# are exactly the same.

# For example, given:

# N = 15 and M = 75, the prime divisors are the same: {3, 5};
# N = 10 and M = 30, the prime divisors aren't the same: {2, 5} is not equal to {2, 3, 5};
# N = 9 and M = 5, the prime divisors aren't the same: {3} is not equal to {5}.
# Write a function:

# def solution(a, b)
# that, given two non-empty arrays A and B of Z integers, returns the number of positions K for which the prime divisors
# of A[K] and B[K] are exactly the same.

# For example, given:

#     A[0] = 15   B[0] = 75
#     A[1] = 10   B[1] = 30
#     A[2] = 3    B[2] = 5
# the function should return 1, because only one pair (15, 75) has the same set of prime divisors.

# Write an efficient algorithm for the following assumptions:

# Z is an integer within the range [1..6,000];
# each element of arrays A, B is an integer within the range [1..2,147,483,647].
# Copyright 2009–2020 by Codility Limited. All Rights Reserved. Unauthorized copying, publication or disclosure prohibited.


A_MAX = 6000
N_MIN = 1
N_MAX = 2147483647

def solution(a,b)
	raise ArgumentError.new("a has to be non empty array with max #{A_MAX} elemens") if !a.is_a? Array or a.empty? or a.length > A_MAX
	raise ArgumentError.new("a elemens only integers") unless a.all?(Integer)
	a_sort = a.sort
	raise ArgumentError.new("a elemens between #{N_MIN} and #{N_MAX}") if a_sort.first < N_MIN or a_sort.last > N_MAX

	raise ArgumentError.new("b has to be non empty array with max #{A_MAX} elemens") if !b.is_a? Array or b.empty? or b.length > A_MAX
	raise ArgumentError.new("b elemens only integers") unless b.all?(Integer)
	b_sort = b.sort
	raise ArgumentError.new("b elemens between #{N_MIN} and #{N_MAX}") if b_sort.first < N_MIN or b_sort.last > N_MAX
	raise ArgumentError.new("a and b have to be of equal size") unless a.size == b.size

	ret = 0

	for i in 0...a.length do
		nopd1 = num_of_prime_divisors(a[i])
		ret +=1 if num_of_prime_divisors(b[i]) == nopd1
	end

	return ret
end


def num_of_prime_divisors(num)
	ret = 0
	max_iter = num/2
	counter = 3
	ret = 1 if num%2 == 0 # check first prime
	while counter < max_iter
		#ret += 1 if num%counter == 0
		if num % counter == 0 && Prime.prime?(counter)
			puts "is prime? #{counter}: " + Prime.prime?(counter).to_s
			puts "num: #{num}, counter: #{counter}, max_iter:  #{max_iter}"
			ret += 1
		end
		counter +=2
	end

	return ret
end


puts solution([2,20000],[2,4000001])
puts solution([15,15,15],[30,75,12])

arr_ok = [1]
assert_raise(ArgumentError.new("a has to be non empty array with max #{A_MAX} elemens")) {solution(1, arr_ok)}
assert_raise(ArgumentError.new("a has to be non empty array with max #{A_MAX} elemens")) {solution([], arr_ok)}
arr = Array.new(A_MAX+1, 1)
assert_raise(ArgumentError.new("a has to be non empty array with max #{A_MAX} elemens")) {solution(arr, arr_ok )}
assert_raise(ArgumentError.new("a elemens only integers")) {solution([1,2,1.2], arr_ok)}
assert_raise(ArgumentError.new("a elemens only integers")) {solution([1,2,'a'], arr_ok)}

assert_raise(ArgumentError.new("b has to be non empty array with max #{A_MAX} elemens")) {solution(arr_ok,1)}
assert_raise(ArgumentError.new("b has to be non empty array with max #{A_MAX} elemens")) {solution(arr_ok,[])}
assert_raise(ArgumentError.new("b has to be non empty array with max #{A_MAX} elemens")) {solution(arr_ok, arr )}
assert_raise(ArgumentError.new("b elemens only integers")) {solution(arr_ok, [1,2,1.2])}
assert_raise(ArgumentError.new("b elemens only integers")) {solution(arr_ok, [1,2,'a'])}

