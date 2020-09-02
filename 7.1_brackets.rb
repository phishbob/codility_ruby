#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
include Test::Unit::Assertions

# A string S consisting of N characters is considered to be properly nested if any of the following conditions
# is true:

# S is empty;
# S has the form "(U)" or "[U]" or "{U}" where U is a properly nested string;
# S has the form "VW" where V and W are properly nested strings.
# For example, the string "{[()()]}" is properly nested but "([)()]" is not.

# Write a function:

# def solution(s)
# that, given a string S consisting of N characters, returns 1 if S is properly nested and 0 otherwise.

# For example, given S = "{[()()]}", the function should return 1 and given S = "([)()]", the function should
# return 0, as explained above.

# Write an efficient algorithm for the following assumptions:

# N is an integer within the range [0..200,000];
# string S consists only of the following characters: "(", "{", "[", "]", "}" and/or ")".


def solution(s)
	puts "--------------------"
	return true if s.length == 0
	my_string = "()[]{}"
	s.each_char do |c|
		raise ArgumentError.new("s may only consist of (){}[]") unless my_string.include? c
	end
	puts "string = #{s}"
	my_hash = {"(" => 0, "[" => 0, "{" => 0}
	vals = {")" => "(", "]" => "[", "}" => "{"}

	nested = Array.new
	s.each_char do |c|
		if "([{".include? c
			nested.push(c)
		else # closing bracket
			if nested.last == vals[c]
				nested.pop
			else
				return false
			end
		end
	end

	return false unless nested.empty?
	return true
end

assert_raise(ArgumentError.new("s may only consist of (){}[]")) {solution("a")}

puts solution("")
puts solution("(")
puts solution("()")
puts solution ("{[()()]}")
puts solution ("([)()]")
puts solution("()(")
puts solution("()}")