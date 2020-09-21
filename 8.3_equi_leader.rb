#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
include Test::Unit::Assertions

# score 66% correctness 100% - performance 25%
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
	#puts "my_h_sort: #{my_h_sort[0][0]}, #{my_h_sort[1]}"
	# -> my_h_sort[value][occurances]
	if my_h_sort.first[1] < a.size/2
		return 0
	end
	leader_val = my_h_sort.first[0]
	#puts "leader_val: #{leader_val}"

	for idx in (0...a.length-1) do
	#for idx in (0...1000) do
		leader = false
		leader2 = false
		count_low = 0

		(0..idx).each do |i|
			count_low += 1 if a[i] == leader_val
		end

		leader = true if count_low > ((idx+1)/2.0)
		#puts "leader: #{leader}, count_low: #{count_low}, treshold = #{(idx+1)/2.0}"
		next unless leader
		count_high = 0
		(idx+1...a.length).each do |i|
			count_high += 1 if a[i] == leader_val
		end

		leader2 = true if count_high > (a.length- idx-1 )/2.0
		#puts "leader2: #{leader2}, count_high: #{count_high}, treshold = #{(a.length- idx-1 )/2.0}"

		ret += 1 if leader && leader2
		puts "-------- ret: #{ret}"
	end
##### END OF CODE



	return ret

end

assert_equal(2, solution([4,3,4,4,4,2])) #2
assert_equal(3, solution([1,2,1,1,1])) #3
assert_equal(3, solution([2,1,1,1,1,1]) )
assert_equal(0, solution([1,2,4,5]))
assert_equal(0, solution([1])) #0
arr = Array.new(1000) { rand(MIN_VAL..MAX_VAL)  }
puts solution(arr)
