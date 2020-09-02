#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
include Test::Unit::Assertions


def solution val
	raise ArgumentError.new("wrong k " + val.to_s) unless val.is_a? Integer #or k<1 or k>100000

	bits = val.to_s(2)
	ret = 0
	switch = nil
	distance = 0
	last_switch = nil
	puts "val: #{val}, bits: #{bits}"

	##find longest gap
	bits.each_char do |bit|
		if bit == "1"
			if switch == 1
				distance = distance +1
			elsif !switch.nil? && !last_switch.nil? # switched from 0 to 1 and was not the first switch
				puts "here"
				distance = distance +1
				ret = distance if distance > ret
				distance = 0
			elsif !switch.nil? && last_switch.nil?

				puts "set - #{bit}"
			end
			switch = 1
		else # bit == "0"
			if switch == 0
				distance = distance +1
			elsif !switch.nil? # switched from 1 to 0 and was not the first switch

				distance = distance +1
				ret = distance if distance > ret

				distance = 0

				puts "empty - #{bit}"
			end
			switch = 0
		end
		puts "ret = #{ret}"
	end #each_char

	puts " -- ret: #{ret}"
	return ret

end
#solution(5)
#solution(7)
solution(8)
#solution(9)
