#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
include Test::Unit::Assertions

# A non-empty array A consisting of N integers is given.

# A triplet (X, Y, Z), such that 0 ≤ X < Y < Z < N, is called a double slice.

# The sum of double slice (X, Y, Z) is the total of A[X + 1] + A[X + 2] + ... + A[Y − 1] + A[Y + 1] + A[Y + 2] + ... + A[Z − 1].

# For example, array A such that:

#     A[0] = 3
#     A[1] = 2
#     A[2] = 6
#     A[3] = -1
#     A[4] = 4
#     A[5] = 5
#     A[6] = -1
#     A[7] = 2
# contains the following example double slices:

# double slice (0, 3, 6), sum is 2 + 6 + 4 + 5 = 17,
# double slice (0, 3, 7), sum is 2 + 6 + 4 + 5 − 1 = 16,
# double slice (3, 4, 5), sum is 0.
# The goal is to find the maximal sum of any double slice.

# Write a function:

# def solution(a)
# that, given a non-empty array A consisting of N integers, returns the maximal sum of any double slice.

# For example, given:

#     A[0] = 3
#     A[1] = 2
#     A[2] = 6
#     A[3] = -1
#     A[4] = 4
#     A[5] = 5
#     A[6] = -1
#     A[7] = 2
# the function should return 17, because no double slice of array A has a sum of greater than 17.

# Write an efficient algorithm for the following assumptions:

# N is an integer within the range [3..100,000];
# each element of array A is an integer within the range [−10,000..10,000].

MIN_LENGTH = 3
MAX_LENGTH = 100000
MIN_VAL = -10000
MAX_VAL =  10000

def solution(a)
	raise ArgumentError.new("a has to be array with more than #{MIN_LENGTH} elements") if !a.is_a? Array or a.length < MIN_LENGTH+1
	raise ArgumentError.new("a may only be #{MAX_LENGTH} elements long") if a.length > MAX_LENGTH
	## only integer
	raise ArgumentError.new("a elements have to be integers") unless a.all?(Integer)
	a_sort = a.sort
	raise ArgumentError.new("a elements have to be integers between #{MIN_VAL}..#{MAX_VAL}") if a_sort.first < MIN_VAL or a_sort.last > MAX_VAL

	ret = nil

	## getting all slices
	(0..a.length-4).each do |x|
		(x+1..a.length-3).each do |y|
			(y+1..a.length-2).each do |z|
				puts "#{x}, #{y}, #{z}"
				# first
				sumx = 0
				sumy = 0
				a[x+1..y-1].each{|x| sumx += x}
				a[y+1..z-1].each{|y| sumy += y}
				total = sumx+sumy
				puts "sumx: #{sumx}, sumy: #{sumy} -> #{sumx+sumy}"
				ret = total if ret.nil? or total > ret

			end
		end
		#puts "#{x} -> #{a[x]}"
	end
	puts "MAX was #{ret}"
	return ret
end

#solution([1,2,3,4,5])
solution([3,2,6,-1,4,5,-1,2])


#     A[0] = 3
#     A[1] = 2
#     A[2] = 6
#     A[3] = -1
#     A[4] = 4
#     A[5] = 5
#     A[6] = -1
#     A[7] = 2

assert_raise(ArgumentError.new("a has to be array with more than #{MIN_LENGTH} elements")) {solution(1)}
assert_raise(ArgumentError.new("a has to be array with more than #{MIN_LENGTH} elements")) {solution([1,2])}
assert_raise(ArgumentError.new("a has to be array with more than #{MIN_LENGTH} elements")) {solution([1,2,3])}
arr = Array.new(MAX_LENGTH+1, 1)
assert_raise(ArgumentError.new("a may only be #{MAX_LENGTH} elements long")){solution(arr)}
assert_raise(ArgumentError.new("a elements have to be integers")){solution([1,2,'a',3,4,3])}
assert_raise(ArgumentError.new("a elements have to be integers")){solution([1,2,4.1,3,4,3])}
assert_raise(ArgumentError.new("a elements have to be integers between #{MIN_VAL}..#{MAX_VAL}")){solution([1,MIN_VAL-1,2,4])}
assert_raise(ArgumentError.new("a elements have to be integers between #{MIN_VAL}..#{MAX_VAL}")){solution([1,MAX_VAL+1,2,4])}
