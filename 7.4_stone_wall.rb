#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
include Test::Unit::Assertions

# score 87% . correctness 100%. performance 77%

# You are going to build a stone wall. The wall should be straight and N meters long, and its thickness should be constant;
# however, it should have different heights in different places. The height of the wall is specified by an array H of N
# positive integers. H[I] is the height of the wall from I to I+1 meters to the right of its left end. In particular, H[0] is
# the height of the wall's left end and H[N−1] is the height of the wall's right end.

# The wall should be built of cuboid stone blocks (that is, all sides of such blocks are rectangular). Your task is to compute
# the minimum number of blocks needed to build the wall.

# Write a function:

# def solution(h)
# that, given an array H of N positive integers specifying the height of the wall, returns the minimum number of blocks
# needed to build it.

# For example, given array H containing N = 9 integers:

#   H[0] = 8    H[1] = 8    H[2] = 5
#   H[3] = 7    H[4] = 9    H[5] = 8
#   H[6] = 7    H[7] = 4    H[8] = 8
# the function should return 7. The figure shows one possible arrangement of seven blocks.



# Write an efficient algorithm for the following assumptions:

# N is an integer within the range [1..100,000];
# each element of array H is an integer within the range [1..1,000,000,000].


#MIN_LEN = 1
MAX_LENGTH = 100000
MIN_VAL = 1
MAX_VAL = 1000000000

def solution(h) # 77% performance
	raise ArgumentError.new("h has to be non empty array") if !h.is_a? Array or h.empty?
	raise ArgumentError.new("h may only be #{MAX_LENGTH} elements long") if h.length > MAX_LENGTH

	steps = 0
	blocks = Array.new(h.size,0)

	h.each_with_index do |height, i|
		raise ArgumentError.new("h values have to be integers between #{MIN_VAL}..#{MAX_VAL}") if !height.is_a? Integer or height < MIN_VAL or height > MAX_VAL

		# we find a bigger block than actually on this index in blocks
		if height > blocks[i]
			steps += 1
			j = i
			while j < h.size	&& height <= h[j]
				blocks[j] = height
				j += 1
#				puts blocks.inspect
			end
#			puts "---"
		end

	end # each with index
#	puts "steps: #{steps}"
	return steps
end





# h1 = [8,8,5,7,9,8,7,4,8]
# assert_equal(7,solution(h1))
# assert_equal(3, solution([3,3,1,2,2]))
# assert_raise(ArgumentError.new("h values have to be integers between 1..1000000000")) {solution([3,3,1,2,MAX_VAL+1])}
