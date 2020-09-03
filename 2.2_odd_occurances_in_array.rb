#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
include Test::Unit::Assertions

# 100%

# A non-empty array A consisting of N integers is given. The array contains an odd number of elements,
# and each element of the array can be paired with another element that has the same value, except for
# one element that is left unpaired.

# For example, in array A such that:

#   A[0] = 9  A[1] = 3  A[2] = 9
#   A[3] = 3  A[4] = 9  A[5] = 7
#   A[6] = 9
# the elements at indexes 0 and 2 have value 9,
# the elements at indexes 1 and 3 have value 3,
# the elements at indexes 4 and 6 have value 9,
# the element at index 5 has value 7 and is unpaired.
# Write a function:

# def solution(a)
# that, given an array A consisting of N integers fulfilling the above conditions, returns the
# value of the unpaired element.

# For example, given array A such that:

#   A[0] = 9  A[1] = 3  A[2] = 9
#   A[3] = 3  A[4] = 9  A[5] = 7
#   A[6] = 9
# the function should return 7, as explained in the example above.

# Write an efficient algorithm for the following assumptions:

# N is an odd integer within the range [1..1,000,000];
# each element of array A is an integer within the range [1..1,000,000,000];
# all but one of the values in A occur an even number of times.


MIN_VAL = 1
MAX_VAL = 1000000000
A_MIN  = 1
A_MAX = 1000000

def solution(a)
	#puts "START with array of length #{a.length}"
	raise ArgumentError.new("a has to be non empty array with max #{A_MAX} elements") if !a.is_a? Array or a.empty? or a.length > A_MAX
	raise ArgumentError.new("a has to be odd array") if a.length%2 == 0

	matches = Hash.new

	a.each do |elem|
		raise ArgumentError.new("a values between #{MIN_VAL} and #{MAX_VAL}") if elem < MIN_VAL or elem > MAX_VAL
		raise ArgumentError.new("a values only integers") unless elem.is_a? Integer

		if matches[elem]
			matches.delete(elem)
		else
			matches[elem] = true
		end
	end

	if matches.length == 1
		return matches.keys.first
	else
		raise ArgumentError.new("matches should contain 1 element but contained #{matches.keys}")
	end


	### slow solution
# 	#res = Array.new
# 	i =  0
# 	while i < a_sort.length do
# #		break if i == a.length
# 		puts "#{i} : #{a_sort[i]} == #{a_sort[i+1]}"
# 		if a_sort[i] == a_sort[i+1] ## equal values step once more
# 			i += 1
# 		else
# 			return a_sort[i] #unpaired element
# 		end
# 		i += 1
# 	end

	return matches.keys.first
end


def gen_arr(len, odd)
	#ret = Array.new(len*2+1)
	ret = Array.new
	(0...(len/2-1)).each do |i|
		num = rand(MIN_VAL..MAX_VAL)
		ret.push(num,num)
	end
	# (1..len).step(2).each do |i|
	# 	num = rand(N_MIN..N_MAX)
	# 	ret.push(num, num)
	# end
	ret.push(odd)
	#puts "ret ....... = #{ret.sort}"
	ret.shuffle!
	#puts "ret shuffle = #{ret}"
	return ret
end


puts solution(gen_arr(A_MAX,3))
puts solution([1,4,4,2,1])
puts solution([9,3,9,3,9,7,9])



assert_raise(ArgumentError.new("a has to be non empty array with max #{A_MAX} elements")){solution([])}
assert_raise(ArgumentError.new("a has to be non empty array with max #{A_MAX} elements")){solution(1)}

assert_raise(ArgumentError.new("a has to be odd array")){solution(Array.new(10,1))}
assert_raise(ArgumentError.new("a values only integers")){solution([1.2])}
assert_raise(ArgumentError.new("a values between #{MIN_VAL} and #{MAX_VAL}")){solution([1,2,MIN_VAL-1,3,4])}
assert_raise(ArgumentError.new("a values between #{MIN_VAL} and #{MAX_VAL}")){solution([1,2,MAX_VAL+1,3,4])}
