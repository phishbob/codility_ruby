#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
require "prime"
include Test::Unit::Assertions


def my_test
	puts fib(1)
	puts fib(2)
	puts fib(3)
	puts fib(4)
	puts fib(5)
	puts fib(6)
	puts fib(7)
end

def fib(n)
	return 1 if n == 1
	return (fib(n-1)) + (fib(n-2)) if n >= 2
	return 0 if n < 1
end



my_test()