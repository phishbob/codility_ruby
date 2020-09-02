#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
include Test::Unit::Assertions

# the largest length array we have to handle
MAX_LENGTH = 1000


def solution(arr)
	raise ArgumentError.new("no array") unless arr.kind_of?(Array)
	raise ArgumentError.new("array too long") unless arr.size <= MAX_LENGTH


	arr.sort!
	#puts "array       : #{arr}"
	odd_elements = Array.new
	first = true

	i = 0
	len = arr.size
	while i < len
		if arr[i] == arr[i+1] && i <len+1 ## equal values. step 2 to next values
			i = i+1
		elsif arr[i] != arr[i+1] # values are not equal
			odd_elements.push(arr[i])
			#puts "odd_element ---> #{odd_element}"
		end
		i = i +1
	end

	#puts "odd_element = #{odd_element}"
	if odd_elements.size != 1
		raise StandardError.new("There should be be one Element but was: #{odd_elements}")
	end
	return odd_elements[0]
end




def gen_arr(len, odd)
	#ret = Array.new(len*2+1)
	ret = Array.new
	(1..len).step(2).each do |i|
		num = rand(-1000..1000)
		ret.push(num, num)
	end
	ret.push(odd)
	#puts "ret ....... = #{ret.sort}"
	ret.shuffle!
	#puts "ret shuffle = #{ret}"
	return ret
end

#puts gen_arr(3,10)



assert_raise(ArgumentError.new("no array")) {solution("x")}
assert_equal(-1100, solution(gen_arr(10,-1100)))
assert_equal(1100,solution(gen_arr(10,1100)))
assert_equal(11,solution(gen_arr(10,11)))
assert_raise(ArgumentError.new("array too long")) {solution(gen_arr(1000,1))}
assert_raise(StandardError.new("There should be be one Element but was: [5, 6]")) {solution([1,3,5,1,3,6])}
assert_raise(StandardError.new("There should be be one Element but was: []")) {solution([1,3,5,1,3,5])}
# solution()
# puts "---"
# solution([5,3,5,1,3])

