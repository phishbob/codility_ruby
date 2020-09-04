#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
include Test::Unit::Assertions

# score 100%  -> correctness 100%, perfomance 40%

# You are given N counters, initially set to 0, and you have two possible operations on them:

# increase(X) − counter X is increased by 1,
# max counter − all counters are set to the maximum value of any counter.
# A non-empty array A of M integers is given. This array represents consecutive operations:

# if A[K] = X, such that 1 ≤ X ≤ N, then operation K is increase(X),
# if A[K] = N + 1 then operation K is max counter.
# For example, given integer N = 5 and array A such that:

#     A[0] = 3
#     A[1] = 4
#     A[2] = 4
#     A[3] = 6
#     A[4] = 1
#     A[5] = 4
#     A[6] = 4
# the values of the counters after each consecutive operation will be:

#     (0, 0, 1, 0, 0)
#     (0, 0, 1, 1, 0)
#     (0, 0, 1, 2, 0)
#     (2, 2, 2, 2, 2)
#     (3, 2, 2, 2, 2)
#     (3, 2, 2, 3, 2)
#     (3, 2, 2, 4, 2)
# The goal is to calculate the value of every counter after all operations.

# Write a function:

# def solution(n, a)
# that, given an integer N and a non-empty array A consisting of M integers, returns a sequence of integers
# representing the values of the counters.

# Result array should be returned as an array of integers.

# For example, given:

#     A[0] = 3
#     A[1] = 4
#     A[2] = 4
#     A[3] = 6
#     A[4] = 1
#     A[5] = 4
#     A[6] = 4
# the function should return [3, 2, 2, 4, 2], as explained above.

# Write an efficient algorithm for the following assumptions:

# N and M are integers within the range [1..100,000];
# each element of array A is an integer within the range [1..N + 1].


RANGE_MAX = 100000
RANGE_MIN = 1

def solution(n,a)
	raise ArgumentError.new("n muss zwischen #{RANGE_MIN} und #{RANGE_MAX} liegen") if n < RANGE_MIN or n > RANGE_MAX
	raise ArgumentError.new("a muss Array und darf nicht leer sein") if  !a.is_a? Array or a.empty?
#	a_sort = a.sort
	#raise ArgumentError.new("die werte von a müssen zwischen 1 und #{n+1} liegen") if a_sort.first < 1 or a_sort.last > n+1

	#create return array
	ret = Array.new(n,0)
	max_val = 0
	min_val = 0
	a.each do |elem|
		raise ArgumentError.new("die werte von a müssen zwischen 1 und #{n+1} liegen") if elem < 1 or elem > n+1
		#puts "#{elem}, array before: #{ret.inspect}"
		if elem > n
			#puts "in if. max_val: #{max_val}"
			#ret.collect! {max_val}
			min_val = max_val
		else
			if ret[elem-1] < min_val
				ret[elem-1] = min_val+1
			else
				ret[elem-1] += 1
			end
			max_val = ret[elem-1] if ret[elem-1] > max_val
		end
	end

	(0...ret.length).each do |i|
		ret[i] = min_val if ret[i] < min_val
	end
	return ret
end

puts solution(3, [1,2,4,2,3]).inspect



puts solution(5,[3, 4, 4, 6, 1, 4, 4]).inspect

arr = Array.new(10000) { |i| 		rand(1..100001)  }
solution(100000, arr)

#solution(1,2)
assert_raise(ArgumentError.new("n muss zwischen #{RANGE_MIN} und #{RANGE_MAX} liegen")) {solution(RANGE_MIN-1,[2])}
assert_raise(ArgumentError.new("n muss zwischen #{RANGE_MIN} und #{RANGE_MAX} liegen")) {solution(RANGE_MAX+1,[1])}
assert_raise(ArgumentError.new("a muss Array und darf nicht leer sein")) {solution(RANGE_MIN,2)}
assert_raise(ArgumentError.new("a muss Array und darf nicht leer sein")) {solution(RANGE_MIN,[])}

assert_raise(ArgumentError.new("die werte von a müssen zwischen 1 und 7 liegen")) {solution(6,[20, 2, 3])}
assert_raise(ArgumentError.new("die werte von a müssen zwischen 1 und 4 liegen")) {solution(3,[1,-1, 2, 3])}
