#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
include Test::Unit::Assertions

# score 100%

# You are given two non-empty arrays A and B consisting of N integers. Arrays A and B represent N voracious fish in a river,
# ordered downstream along the flow of the river.

# The fish are numbered from 0 to N − 1. If P and Q are two fish and P < Q, then fish P is initially upstream of fish Q. Initially,
# each fish has a unique position.

# Fish number P is represented by A[P] and B[P]. Array A contains the sizes of the fish. All its elements are unique. Array B contains
# the directions of the fish. It contains only 0s and/or 1s, where:

#         0 represents a fish flowing upstream,
#         1 represents a fish flowing downstream.

# If two fish move in opposite directions and there are no other (living) fish between them, they will eventually meet each other.
# Then only one fish can stay alive − the larger fish eats the smaller one. More precisely, we say that two fish P and Q meet each
# other when P < Q, B[P] = 1 and B[Q] = 0, and there are no living fish between them. After they meet:

#         If A[P] > A[Q] then P eats Q, and P will still be flowing downstream,
#         If A[Q] > A[P] then Q eats P, and Q will still be flowing upstream.

# We assume that all the fish are flowing at the same speed. That is, fish moving in the same direction never meet. The goal is to calculate
# the number of fish that will stay alive.

# For example, consider arrays A and B such that:
#   A[0] = 4    B[0] = 0
#   A[1] = 3    B[1] = 1
#   A[2] = 2    B[2] = 0
#   A[3] = 1    B[3] = 0
#   A[4] = 5    B[4] = 0

# Initially all the fish are alive and all except fish number 1 are moving upstream. Fish number 1 meets fish number 2 and eats it, then it meets
# fish number 3 and eats it too. Finally, it meets fish number 4 and is eaten by it. The remaining two fish, number 0 and 4, never meet and therefore
# stay alive.

# Write a function:

#     def solution(a, b)

# that, given two non-empty arrays A and B consisting of N integers, returns the number of fish that will stay alive.

# For example, given the arrays shown above, the function should return 2, as explained above.

# Write an efficient algorithm for the following assumptions:

#         N is an integer within the range [1..100,000];
#         each element of array A is an integer within the range [0..1,000,000,000];
#         each element of array B is an integer that can have one of the following values: 0, 1;
#         the elements of A are all distinct.



ARR_LENGTH_MIN = 1
ARR_LENGTH_MAX = 100000
A_MIN = 0
A_MAX = 1000000000

def solution(a,b)
	raise ArgumentError.new("a and b both array of equal length!") if !a.is_a? Array or !b.is_a? Array or a.empty? or b.empty? or a.length != b.length
	a_sort = a.sort
	raise ArgumentError.new("#{a_sort.first}, #{a_sort.last} values between #{A_MIN} and #{A_MAX}") if a.first < A_MIN or a.last > A_MAX
	a_sort.each_index do |i|
		raise ArgumentError.new("only distinct values for a allowed")  if a_sort[i] == a_sort[i+1]
	end

	ret = 0
	fish = []
	(0...a.length).each do |i|
		#raise ArgumentError.new("#{a[i]} between #{A_MIN} and #{A_MAX}") if a[i] < A_MIN or a[i] > A_MAX
		raise ArgumentError.new("#{b[i]} either 0 or 1 ") if b[i] != 0 and b[i] != 1

		if fish.empty? && b[i] == 0
			ret += 1
			next
		elsif fish.empty? && b[i] = 1
			fish.push(a[i],b[i])  # 0 -> size, 1 -> direction
			next
		end


		if b[i] == fish.last # same direction as last fish
			fish.push(a[i],b[i])
		else # different direction
			puts "fish -> " + fish.inspect + "incoming: #{a[i]}, #{b[i]}"
			while !fish.empty? do
				if fish[-2] > a[i] # stored fish is bigger than incoming fish
					puts "if"
					break # we just eat it
				else
					puts "else"
					fish.pop(2)
					ret += 1 if fish.empty?
				end
			end # while
		end # if else
	end

	puts "END #{fish.inspect}"

	ret = ret + (fish.length/2)

	return ret
end

# a = [4,3,2,1,5]
# b = [0,1,0,0,0]
# assert_equal(1, solution(a,b)) # 1

# a = [4,3,2,1,5]
# b = [0,0,0,0,0]
# assert_equal(5, solution(a,b)) # 5

# a = [4,3,2,1,5]
# b = [1,1,1,1,1]
# assert_equal(5, solution(a,b)) # 5

# a = [4,3,2,1,5]
# b = [0,0,0,1,1]
# assert_equal(5, solution(a,b)) # 5


a = [4,3,2,1,4]
b = [0,0,0,1,1]
assert_raise(ArgumentError.new("only distinct values for a allowed")) { solution(a,b)} # 5


a = [A_MAX, 3]
b = [0,1]
puts solution(a,b) # 1
