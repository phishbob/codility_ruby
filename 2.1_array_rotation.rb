#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
include Test::Unit::Assertions

#A size -1000,1000
#K 0, 100


# Rotate the array A by k steps
# :param A: an array of integers
# :param K: number of times to shift right
# :return: the rotated array
def solution(a,k)
	raise ArgumentError.new("a is no array") unless a.is_a? Array
	raise ArgumentError.new("k has to be set") if k.nil? or !k.is_a? Integer
	return a if a.empty?
	puts "k%a.length: #{-k%a.length}"

	return a.rotate(-k%a.length)
end


assert_raise(ArgumentError.new("k has to be set")) {solution([],nil)}
assert_raise(ArgumentError.new("k has to be set")) {solution([],'a')}

puts solution([3, 8, 9, 7, 6], 3).inspect
puts solution([], 0).inspect
puts solution([0], 32).inspect
# puts  solution([1,2,3],5)
# puts "---"
# puts  solution([1,2,3],2)
# puts  solution([1,2,3],1)
