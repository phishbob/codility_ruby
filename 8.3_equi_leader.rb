#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
include Test::Unit::Assertions

# score 55% correctness 100% - performance 0%
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

	for idx in (0...a.length-1) do
		#puts "IDX ------> #{idx}-------" if idx%100 == 0
		count_low = Hash.new
		leader = false
		count1 = idx/2+1
		#puts "count1: #{count1}"
		(0..idx).each do |i|
			if count_low[a[i]]
			 	count_low[a[i]] = count_low[a[i]] +1
			elsif i < count1
			 	count_low[a[i]] = 1
			end
			 # unless count_low[a[i]]
			 # else
			 # 	count_low[a[i]] = count_low[a[i]] +1
			 # end
		end
		s1 = count_low.sort_by {|k, v| -v}.first
		#puts "count_low sorted: #{count_low.inspect}"

		leader = true if s1[1] > (idx+1)/2.0
		#puts "count1 : #{count1}"
		next unless leader
		count2 = (a.length - idx) /2 + idx +1
		#puts "count2 : #{count2}"

		leader2 = false
		count_high = Hash.new
		(idx+1...a.length).each do |i|
			if count_high[a[i]]
				count_high[a[i]] = count_high[a[i]] +1
			elsif i < count2
				count_high[a[i]] = 1
			end
			 # unless
			 # 	count_high[a[i]] = 1
			 # else
			 # 	count_high[a[i]] = count_high[a[i]] +1
			 # end
		end

		s2 = count_high.sort_by {|k, v| -v}.first
		#puts "#{count_high.inspect}"
		#puts "count_high sorted: #{s2.inspect}"
		#puts "len 2 = #{(a.length-idx-1 )/2.0 }"
		#puts "#{s2[1]} > #{(a.length- idx-1 )/2.0}"
		leader2 = true if s2[1] > (a.length- idx-1 )/2.0

		#puts "++ leader: #{leader}, leader2: #{leader2}, #{s1[0]}, #{s2[0]}"
		if leader && leader2 && s1[0] == s2[0]
			#puts "++++ we have a equi leader: #{s1[0]} ++++"
			ret += 1
		end

	end
	return ret

end

#assert_equal(2, solution([4,3,4,4,4,2])) #2
#assert_equal(3, solution([1,2,1,1,1])) #3
#assert_equal(3, solution([2,1,1,1,1,1]) )
#assert_equal(0, solution([1,2,4,5]))
#assert_equal(0, solution([1])) #0
arr = Array.new(MAX_LEN) { rand(MIN_VAL..MAX_VAL)  }
puts solution(arr)
