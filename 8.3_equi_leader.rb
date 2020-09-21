#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
include Test::Unit::Assertions

# score 100%
# A non-empty array A consisting of N integers is given.

# The leader of this array is the value that occurs in more than half of the elements of A.

# An equi leader is an index S such that 0 ≤ S < N − 1 and two sequences A[0], A[1], ..., A[S]
# and A[S + 1], A[S + 2], ..., A[N − 1] have leaders of the same value.

# For example, given array A such that:
#     A[0] = 4
#     A[1] = 3
#     A[2] = 4
#     A[3] = 4
#     A[4] = 4
#     A[5] = 2

# we can find two equi leaders:

#         0, because sequences: (4) and (3, 4, 4, 4, 2) have the same leader, whose value is 4.
#         2, because sequences: (4, 3, 4) and (4, 4, 2) have the same leader, whose value is 4.

# The goal is to count the number of equi leaders.

# Write a function:

#     def solution(a)

# that, given a non-empty array A consisting of N integers, returns the number of equi leaders.

# For example, given:
#     A[0] = 4
#     A[1] = 3
#     A[2] = 4
#     A[3] = 4
#     A[4] = 4
#     A[5] = 2

# the function should return 2, as explained above.

# Write an efficient algorithm for the following assumptions:

#         N is an integer within the range [1..100,000];
#         each element of array A is an integer within the range [−1,000,000,000..1,000,000,000].


MIN_LEN = 1
MAX_LEN = 100000
MIN_VAL = -1000000000
MAX_VAL =  1000000000


# length of equi leader can be 1
def solution(a)
	raise ArgumentError.new("a has to be non empty array of max size #{MAX_LEN}") if !a.is_a? Array or a.empty? or a.length > MAX_LEN
	ret = 0
	#puts a.inspect
	my_h = Hash.new
	a.each do |e|
		if my_h.include? e
			my_h[e] += 1
		else
			my_h[e] = 1
		end
	end

	my_h_sort = my_h.sort_by {|k, v| -v}
	# -> my_h_sort[value][occurances]
	return 0 if my_h_sort.first[1] < a.size/2
	leader_val = my_h_sort.first[0]

	occ_array = Array.new
	occurances = 0
	a.each do |e|
		occurances += 1 if e == leader_val
		occ_array.push(occurances)
	end
	#puts occ_array.inspect

	for idx in (0...a.length-1) do
		sum1 = occ_array[idx]
		sum2 = occ_array.last - occ_array[idx]

		# puts "#{idx}+1  < #{sum1*2}"
		# puts "#{(a.length - idx -1)}  < #{(sum2*2 )} "

		if (idx+1)  < sum1 * 2 &&  (a.length - idx - 1 )   < sum2 * 2
			## we have a leader
			#puts "YEAH #{idx}"
			ret += 1
		end
			#puts "-------- ret: #{ret}"
	end
	return ret
end

assert_equal(2, solution([4,3,4,4,4,2])) #2
assert_equal(3, solution([1,2,1,1,1])) #3
assert_equal(3, solution([2,1,1,1,1,1]) )
assert_equal(0, solution([1,2,4,5]))
assert_equal(1, solution([0,0]))
assert_equal(0, solution([1])) #0
arr = Array.new((MAX_LEN/2)-1,1)
arr2 = Array.new((MAX_LEN/2)+1,2)
puts solution((arr+arr2).shuffle)
