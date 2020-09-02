#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
include Test::Unit::Assertions

# A non-empty array A consisting of N integers is given.

# A peak is an array element which is larger than its neighbours. More precisely, it is an index P such that 0 < P < N − 1 and A[P − 1] < A[P] > A[P + 1].

# For example, the following array A:

#     A[0] = 1
#     A[1] = 5
#     A[2] = 3
#     A[3] = 4
#     A[4] = 3
#     A[5] = 4
#     A[6] = 1
#     A[7] = 2
#     A[8] = 3
#     A[9] = 4
#     A[10] = 6
#     A[11] = 2
# has exactly four peaks: elements 1, 3, 5 and 10.

# You are going on a trip to a range of mountains whose relative heights are represented by array A, as shown in a figure below. You have to choose how many flags you should take with you. The goal is to set the maximum number of flags on the peaks, according to certain rules.



# Flags can only be set on peaks. What's more, if you take K flags, then the distance between any two flags should be greater than or equal to K. The distance between indices P and Q is the absolute value |P − Q|.

# For example, given the mountain range represented by array A, above, with N = 12, if you take:

# two flags, you can set them on peaks 1 and 5;
# three flags, you can set them on peaks 1, 5 and 10;
# four flags, you can set only three flags, on peaks 1, 5 and 10.
# You can therefore set a maximum of three flags in this case.

# Write a function:

# def solution(a)
# that, given a non-empty array A of N integers, returns the maximum number of flags that can be set on the peaks of the array.

# For example, the following array A:

#     A[0] = 1
#     A[1] = 5
#     A[2] = 3
#     A[3] = 4
#     A[4] = 3
#     A[5] = 4
#     A[6] = 1
#     A[7] = 2
#     A[8] = 3
#     A[9] = 4
#     A[10] = 6
#     A[11] = 2
# the function should return 3, as explained above.

# Write an efficient algorithm for the following assumptions:
# N is an integer within the range [1..400,000];
# each element of array A is an integer within the range [0..1,000,000,000].

N_MIN = 1
N_MAX = 400000
MIN_VAL = 0
MAX_VAL = 1000000000

def solution(a)
	puts
	raise ArgumentError.new("a has to be non empty array with max #{N_MAX} elemens") if !a.is_a? Array or a.empty? or a.length > N_MAX
	raise ArgumentError.new("a elemens only integers") unless a.all?(Integer)

	#find peaks -> with distance to next peak
	peak = Hash.new
	a.each_with_index do |elem,i|
		puts peak
		if i == 0
			peak[i] = elem if a[i+1] < elem
		elsif i < a.length-1
			peak[i] = elem if a[i+1] < elem && a[i-1] < elem
		else
			peak[i] = elem if a[i-1] < elem
		end
	end
	puts "END -> #{peak}, #{peak.length}"

	# place flags
	max_flags = 0
	(1..peak.length).each do |num_flags|
		# i = number of flags and distance
		#flags_to_go = i
		set_flags = 0
		last_pos = nil
		peak.each do |position, peak|
			puts "#{peak}, pos: #{position}, last_pos: #{last_pos}, distance: #{num_flags}"
			if last_pos.nil?
				set_flags += 1
				last_pos = position
			elsif position - last_pos > num_flags # distance is bigger
				set_flags += 1
				last_pos = position
			end
			puts "position - last_pos -> #{position - last_pos}"
			if set_flags >= num_flags
				max_flags = num_flags
				break
			end
		end
	end

	puts "max_flags: #{max_flags}"
	return max_flags
end


a0 = [1,5,3,4,3,4,1,2,3,4,6,2]
solution(a0)

assert_raise(ArgumentError.new("a has to be non empty array with max #{N_MAX} elemens")) {solution(1)}
assert_raise(ArgumentError.new("a has to be non empty array with max #{N_MAX} elemens")) {solution([])}
arr = Array.new(N_MAX+1, 1)
assert_raise(ArgumentError.new("a has to be non empty array with max #{N_MAX} elemens")) {solution(arr)}
assert_raise(ArgumentError.new("a elemens only integers")) {solution([1,2,1.2])}
assert_raise(ArgumentError.new("a elemens only integers")) {solution([1,2,'a'])}
