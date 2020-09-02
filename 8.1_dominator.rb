#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
include Test::Unit::Assertions


# An array A consisting of N integers is given. The dominator of array A is the value that occurs in more than half
# of the elements of A.

# For example, consider array A such that

#  A[0] = 3    A[1] = 4    A[2] =  3
#  A[3] = 2    A[4] = 3    A[5] = -1
#  A[6] = 3    A[7] = 3
# The dominator of A is 3 because it occurs in 5 out of 8 elements of A (namely in those with indices 0, 2, 4, 6 and 7)
# and 5 is more than a half of 8.

# Write a function

# def solution(a)
# that, given an array A consisting of N integers, returns index of any element of array A in which the dominator of A occurs. The function should return −1 if array A does not have a dominator.

# For example, given array A such that

#  A[0] = 3    A[1] = 4    A[2] =  3
#  A[3] = 2    A[4] = 3    A[5] = -1
#  A[6] = 3    A[7] = 3
# the function may return 0, 2, 4, 6 or 7, as explained above.

# Write an efficient algorithm for the following assumptions:

# N is an integer within the range [0..100,000];
# each element of array A is an integer within the range [−2,147,483,648..2,147,483,647].

MAX_LENGTH = 100000
MIN_VAL = -2147483648
MAX_VAL =  2147483647

def solution(a)
	raise ArgumentError.new("a has to be array") if !a.is_a? Array# or a.empty?
	raise ArgumentError.new("a may only be #{MAX_LENGTH} elements long") if a.length > MAX_LENGTH
	## only integer
	raise ArgumentError.new("a elements have to be integers") unless a.all?(Integer)
	a_sort = a.sort
	raise ArgumentError.new("a elements have to be integers between #{MIN_VAL}..#{MAX_VAL}") if a_sort.first < MIN_VAL or a_sort.last > MAX_VAL
	return -1 if a.empty?
	#ret = Arary.new
	res = Hash.new
	a.each do |elem|
		res[elem] = res[elem].nil? ? 1 : res[elem]+1
	end

	k,v = res.sort_by{|k,v| v}.last
	puts "k = #{k}, v = #{v}"
	puts "res = #{res}, sort: #{res.sort_by{|k,v| v}.last}"
	puts "#{v} < #{a.length.to_f/2} ?? "


	return -1 if v < a.length.to_f/2


	#find occurances of v
	ret = Array.new
	a.each_with_index do |elem, idx|
		next if elem != k
		return idx
		ret.push(idx)
	end

	return -2


end

a = [1,2,4]
puts solution(a)

a = [1,2,3,3,2,3,2]
puts solution(a)


a = [1,3,3,2,3,2]
puts solution(a)
a = [3,4,3,2,3,-1,3,3]
puts solution(a)
#  A[0] = 3    A[1] = 4    A[2] =  3
#  A[3] = 2    A[4] = 3    A[5] = -1
#  A[6] = 3    A[7] = 3


assert_raise(ArgumentError.new("a has to be array")) {solution(1)}
arr = Array.new(MAX_LENGTH+1, 1)
assert_raise(ArgumentError.new("a may only be #{MAX_LENGTH} elements long")){solution(arr)}
assert_raise(ArgumentError.new("a elements have to be integers")){solution([1,2,'a',3])}
assert_raise(ArgumentError.new("a elements have to be integers")){solution([1,2,4.1,3])}
assert_raise(ArgumentError.new("a elements have to be integers between #{MIN_VAL}..#{MAX_VAL}")){solution([1,MIN_VAL-1,2])}
assert_raise(ArgumentError.new("a elements have to be integers between #{MIN_VAL}..#{MAX_VAL}")){solution([1,MAX_VAL+1,2])}
