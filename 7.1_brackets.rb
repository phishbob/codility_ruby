#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
include Test::Unit::Assertions

# score 100%

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

MAX_LENGTH = 200000

def solution(s)
	raise ArgumentError.new("s has to be string with max length of #{MAX_LENGTH}") if !s.is_a? String or s.length > MAX_LENGTH
	return 0 if s.length%2 > 0

#	puts "s = #{s}"

	vals = {")" => "(", "]" => "[", "}" => "{"}
	res = []
	s.each_char do |c|
	#	puts "c: #{c} || res: #{res.inspect}"
		if "[({".include? c
			res.push c
		elsif "]})".include? c
			if res.last == vals[c]
				res.pop
			else
				#puts "meh. #{c}, res: #{res.inspect}"
				return 0
			end
		else
			raise ArgumentError.new("only following characters allowed: '[](){}' ") unless '[](){}'.include? c
		end
	end

	#puts res.inspect
	return 0 if res.length > 0
	return 1
end

assert_equal(0, solution("()()()())")) # 0 - uneven number of brackets
assert_equal(1, solution("()()()()")) # 1
assert_equal(1, solution("([((((()))))])")) #1
assert_equal(0, solution("([((((())))]))")) # 0

#assert_equal(1, solution("{[()()]}")) #1
#assert_equal(0, solution("([)()]")) #0
assert_raise( ArgumentError.new("only following characters allowed: '[](){}' ")){solution("([((((()))))b]")}

# assert_raise( ArgumentError.new("s has to be string with max length of #{MAX_LENGTH}")) {solution(12)}
# s = "a"*(MAX_LENGTH+1)
# assert_raise( ArgumentError.new("s has to be string with max length of #{MAX_LENGTH}")) {solution(s)}
