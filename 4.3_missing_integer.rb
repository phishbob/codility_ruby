#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
include Test::Unit::Assertions


# Write a function:
# def solution(a)
# that, given an array A of N integers, returns the smallest positive integer (greater than 0) that does not
# occur in A.

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

	## now the algorithm
	last_val = nil
	#puts a_sort
	a_sort.each do |val|
		if last_val == nil
			last_val = val
		elsif last_val +1 == val
			last_val = val
		else # we have a gap
			break
		end
	end

	return 1 if last_val < 1
	return last_val + 1
end

# assert_raise(ArgumentError.new("a has to be a non empty array")){solution(1)}
# assert_raise(ArgumentError.new("a has to be a non empty array")){solution([])}
# arr = Array.new(1000001) { |i| 1  }
# assert_raise(ArgumentError.new("Array length max: #{N_MAX}")){solution(arr)}
# assert_raise(ArgumentError.new("Array values have to be between #{I_MIN} and #{I_MAX}")){solution([1, I_MIN-1])}
# assert_raise(ArgumentError.new("Array values have to be between #{I_MIN} and #{I_MAX}")){solution([1, I_MAX+1, 2])}
# assert_raise(ArgumentError.new("Array values have all to be Integers")){solution(["1", I_MAX, 2])}

puts solution([-2,-1,-5])
puts solution([1,-1])
puts solution([-3,-1,0])
puts solution([1,2,3,5,6])