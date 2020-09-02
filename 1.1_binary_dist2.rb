#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
include Test::Unit::Assertions

MAXINT = 2147483647

def solution(n)
		raise ArgumentError.new("k is no integer") unless n.is_a? Integer #or k<1 or k>100000
		raise ArgumentError.new("wrong k - smaller than 0") if n < 0
		raise ArgumentError.new("wrong k - bigger than 2147483647") if n > MAXINT
	#puts "solution(#{n}) -> #{n.to_s(2)}"
	binary = n.to_s(2)

	is_first = true
	last_bit = nil # 0 or 1
	distance = 0
	ret = 0

	binary.each_char do |c|
		b = c.to_i
		last_bit = b if last_bit.nil?

		distance = distance +1 unless is_first

		if last_bit != b # switch in bits
			ret = distance  if ret < distance or is_first
			distance = 0
			last_bit = b
			is_first = false if is_first # change is_first only after first last_bit switch
		end
		#puts "distance = #{distance}, ret = #{ret}"

	end
	#	puts "END ret = #{ret}"
	return ret
end
# wrong
#solution("hans")
# assert_raise_message(ArgumentError, "k is no integer") do
# 	solution('a')
# end
assert_raise(ArgumentError.new("k is no integer")) {solution('a')}
assert_raise(ArgumentError.new("wrong k - smaller than 0"))  {solution -1}
assert_raise(ArgumentError.new("wrong k - bigger than 2147483647")) {solution (MAXINT+1)}
#assert_false solution('a')
#assert_false solution(-1) # too small
#assert_false solution(MAXINT+1) # too big““¶¶¶¶¶

# correct
#solution(5)
assert_equal solution(5),1  # 101 -> 1
assert_equal solution(7),0 # 111 -> 0
assert_equal solution(8),0 # 1000 -> 0
assert_equal solution(9),2 # 1001 -> 2
assert_equal solution(93),3 # 1011101 -> 3
assert_equal solution(145),3 # 10010001 -> 3
assert_equal solution(129),6 # 10000001 -> 6


assert_equal(solution(51712), 2)
assert_equal(solution(561892), 3)
assert_equal(solution(9), 2)
assert_equal(solution(66561), 9)
assert_equal(solution(6291457), 20)
assert_equal(solution(805306369), 27)
assert_equal(solution(1376796946), 5)
assert_equal(solution(1073741825), 29)
assert_equal(solution(1610612737), 28)

