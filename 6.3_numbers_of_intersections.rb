#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
include Test::Unit::Assertions

# score 62% -> 100% correctness, 25% performance
# We draw N discs on a plane. The discs are numbered from 0 to N − 1. An array A of N non-negative integers,
# specifying the radiuses of the discs, is given. The J-th disc is drawn with its center at (J, 0) and radius A[J].

# We say that the J-th disc and K-th disc intersect if J ≠ K and the J-th and K-th discs have at least one common point
# (assuming that the discs contain their borders).

# The figure below shows discs drawn for N = 6 and A as follows:

#   A[0] = 1
#   A[1] = 5
#   A[2] = 2
#   A[3] = 1
#   A[4] = 4
#   A[5] = 0


# There are eleven (unordered) pairs of discs that intersect, namely:

# discs 1 and 4 intersect, and both intersect with all the other discs;
# disc 2 also intersects with discs 0 and 3.
# Write a function:

# def solution(a)
# that, given an array A describing N discs as explained above, returns the number of (unordered) pairs of intersecting discs.
# The function should return −1 if the number of intersecting pairs exceeds 10,000,000.

# Given array A shown above, the function should return 11, as explained above.

# Write an efficient algorithm for the following assumptions:

# N is an integer within the range [0..100,000];
# each element of array A is an integer within the range [0..2,147,483,647].

A_MIN = 0
A_MAX = 100000
MIN_VAL = 0
MAX_VAL = 2147483647
MAX_BREAK = 10000000

def solution(a)
	raise ArgumentError.new("a must be array") if !a.is_a? Array
	raise ArgumentError.new("a length must be between #{A_MIN} and #{A_MAX}") if a.length < A_MIN or a.length > A_MAX
	rad_min = Array.new(a.length)
	a.each_with_index do |elem,i|
		if !elem.is_a? Integer or elem < MIN_VAL or elem > MAX_VAL
			raise ArgumentError.new("a elements have to be integers between #{MIN_VAL}..#{MAX_VAL}")
		end
		rad_min[i] =  i- elem # radius minimum
	end

	#puts "rad_min: #{rad_min.inspect}"
	# we can neglect y axis. just get min and max x values for the circles
	intersect = 0
	a_length = a.length
	a.each_with_index do |val1, idx1|
		r1_max = idx1+val1
		(idx1+1...a_length).each do |i|
			#puts "idx1: #{idx1}, i: #{i} r1_max -> #{r1_max}, rad_min[#{i}]: #{rad_min[i]}"
			intersect += 1 if r1_max >= rad_min[i]
		end

		return -1 if intersect > MAX_BREAK
	end

	return intersect
end


puts solution([1, 0, 1, 0, 1])
#puts solution([1,5,2,1,4,0]) #11

puts solution([1,1,1]) # 3
#puts solution([2,2,2,2,2,2,2,2])

#puts solution(Array.new(A_MAX, 3) )
#assert_equal(0, solution(Array.new(10,0)))
#puts solution([MIN_VAL, MAX_VAL,0,1])


# assert_equal(11,solution([1,5,2,1,4,0]))
# assert_raise(ArgumentError.new("a must be array")) {solution(1)}
# arr = Array.new
# (0..A_MAX).each {|val| arr.push(1)}
# assert_raise(ArgumentError.new("a length must be between #{A_MIN} and #{A_MAX}")){solution(arr)}
# assert_raise(ArgumentError.new("a elements have to be integers between #{MIN_VAL}..#{MAX_VAL}")){solution([1,2,'a',3])}
# assert_raise(ArgumentError.new("a elements have to be integers between #{MIN_VAL}..#{MAX_VAL}")){solution([1,MIN_VAL-1,2])}
# assert_raise(ArgumentError.new("a elements have to be integers between #{MIN_VAL}..#{MAX_VAL}")){solution([1,MAX_VAL+1,2])}
