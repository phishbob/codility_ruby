#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
include Test::Unit::Assertions

# score 87%
# For example, for the input '()(()()(((()())(()()))' the solution returned a wrong answer (got 1 expected 0).


# A string S consisting of N characters is called properly nested if:

# S is empty;
# S has the form "(U)" where U is a properly nested string;
# S has the form "VW" where V and W are properly nested strings.
# For example, string "(()(())())" is properly nested but string "())" isn't.

# Write a function:

# def solution(s)
# that, given a string S consisting of N characters, returns 1 if string S is properly nested and 0 otherwise.

# For example, given S = "(()(())())", the function should return 1 and
# given S = "())", the function should return 0, as explained above.

# Write an efficient algorithm for the following assumptions:

# N is an integer within the range [0..1,000,000];
# string S consists only of the characters "(" and/or ")".

MIN_LENGTH = 0
MAX_LENGTH = 1000000
def solution(s)
	raise ArgumentError.new("s length between #{MIN_LENGTH} and #{MAX_LENGTH}") unless s.length >= MIN_LENGTH and s.length <= MAX_LENGTH
	allowed_chars = "()"
	return 0 if s.length % 2 != 0

	stack = 0
	s.each_char do |c|
		raise ArgumentError.new("s only ( and )") unless allowed_chars.include? c
		c == "(" ? stack += 1 : stack -= 1
		puts "stack: #{stack}"
		return 0 if stack < 0
	end

	return 0 if stack != 0
	return 1
end


puts solution('()(()()(((()())(()()))')

# assert_raise(ArgumentError.new("s only ( and )")) {solution("aa")}
# assert_raise(ArgumentError.new("s length between #{MIN_LENGTH} and #{MAX_LENGTH}")) {solution("()" * (MAX_LENGTH/2 +1))}
# assert_equal(1, solution(""))
# assert_equal(0, solution("())"))
# assert_equal(0, solution("()))"))
# assert_equal(0, solution(")))((("))
# assert_equal(1, solution("((()))"))
# assert_equal(1, solution("(()(())())"))
