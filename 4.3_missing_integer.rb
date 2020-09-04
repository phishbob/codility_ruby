#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
include Test::Unit::Assertions

# score 100%

# Write a function:
# def solution(a)
# that, given an array A of N integers, returns the smallest positive integer
# (greater than 0) that does not occur in A.

# For example, given A = [1, 3, 6, 4, 1, 2], the function should return 5.
# Given A = [1, 2, 3], the function should return 4.
# Given A = [−1, −3], the function should return 1.

# Write an efficient algorithm for the following assumptions:

# N is an integer within the range [1..100,000];
# each element of array A is an integer within the range [−1,000,000..1,000,000].

N_MIN = 1
N_MAX = 100000
I_MIN = -1000000
I_MAX = 1000000

def solution(a)
	raise ArgumentError.new("a has to be a non empty array") if !a.is_a? Array or a.empty?
	raise ArgumentError.new("Array length max: #{N_MAX}") if a.length > N_MAX
	raise ArgumentError.new("Array values have all to be Integers") unless a.all? Integer
	a_sort = a.sort
	if (!a_sort.first.is_a? Integer or a_sort.first < I_MIN) or (!a_sort.last.is_a? Integer or a_sort.last > I_MAX)
		raise ArgumentError.new("Array values have to be between #{I_MIN} and #{I_MAX}")
	end

	# we have only positive values starting at a higher number than 1,
	# btw ending on a smaller number than 1
	return 1 if a_sort.first > 1 or a_sort.last < 1
	min_val = 0  #we know we have positive numbers in the array
	a_sort.each do |elem|
		next if elem < min_val # waiting for positive values
		if min_val+1 == elem or min_val == elem
			min_val = elem
		else # found a gap
			break
		end
	end

	return min_val + 1
end


assert_equal(5,solution([1, 3, 6, 4, 1, 2]))
assert_equal(4,solution([1, 2, 3]))
assert_equal(1,solution([0, 2, 3, 4, 5, 6, 7, 8, 9]))
assert_equal(1,solution([3]))

assert_equal(1,solution([-2,-1,-5]))
assert_equal(2,solution([-1,1]))
assert_equal(1,solution([-3,-1,0]))
assert_equal(4,solution([1,2,3,5,6]))

arr = Array.new(10) { |i| i+1-1002 }
brr = Array.new(10) { |i| i }
arr.concat(brr)
assert_equal(10,solution(arr))


assert_raise(ArgumentError.new("a has to be a non empty array")){solution(1)}
assert_raise(ArgumentError.new("a has to be a non empty array")){solution([])}
arr = Array.new(1000001) { |i| 1  }
assert_raise(ArgumentError.new("Array length max: #{N_MAX}")){solution(arr)}
assert_raise(ArgumentError.new("Array values have to be between #{I_MIN} and #{I_MAX}")){solution([1, I_MIN-1])}
assert_raise(ArgumentError.new("Array values have to be between #{I_MIN} and #{I_MAX}")){solution([1, I_MAX+1, 2])}
assert_raise(ArgumentError.new("Array values have all to be Integers")){solution(["1", I_MAX, 2])}
