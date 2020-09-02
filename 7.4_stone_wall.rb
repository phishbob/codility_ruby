#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
include Test::Unit::Assertions


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

MAX_LENGTH = 100000
MIN_VAL = 1
MAX_VAL = 1000000000

def solution(h)
	raise ArgumentError.new("h has to be non empty array") if !h.is_a? Array or h.empty?
	raise ArgumentError.new("h may only be #{MAX_LENGTH} elements long") if h.length > MAX_LENGTH
	h.each do |elem|
		if !elem.is_a? Integer or elem < MIN_VAL or elem > MAX_VAL
			raise ArgumentError.new("h elements have to be integers between #{MIN_VAL}..#{MAX_VAL}")
		end
	end


	res = Array.new(h.length,0)
	steps = 0

	puts "INIT res = #{res}, steps = #{steps}"
	puts "INIT   h = #{h}"

	h.each_with_index do |elem, idx|
		puts "elem : #{elem}, index : #{idx}"

		if res[idx] == elem ## block of same height already there
			next
		elsif res[idx] < elem # elem is bigger than placed block
			for i in idx..h.length-1
				#puts "i = #{i}, h[i] = #{h[i]}"
				break if h[i] < elem
				res[i] = elem # place new block
			end
			puts "res: #{res}"
			steps += 1
		end

	end
	puts "END res : #{res}"
	puts "steps = #{steps}"
	return steps
end

h1 = [8,8,5,7,9,8,7,4,8]
solution(h1)


# assert_raise(ArgumentError.new("h has to be non empty array")) {solution(1)}
# assert_raise(ArgumentError.new("h has to be non empty array")) {solution([])}
# arr = Array.new(MAX_LENGTH+1, 1)
# assert_raise(ArgumentError.new("h may only be #{MAX_LENGTH} elements long")){solution(arr)}
# assert_raise(ArgumentError.new("h elements have to be integers between #{MIN_VAL}..#{MAX_VAL}")){solution([1,2,'a',3])}
# assert_raise(ArgumentError.new("h elements have to be integers between #{MIN_VAL}..#{MAX_VAL}")){solution([1,MIN_VAL-1,2])}
# assert_raise(ArgumentError.new("h elements have to be integers between #{MIN_VAL}..#{MAX_VAL}")){solution([1,MAX_VAL+1,2])}


