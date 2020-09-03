#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
include Test::Unit::Assertions

# success 100%

# A small frog wants to get to the other side of the road. The frog is currently located at position X
# and wants to get to a position greater than or equal to Y. The small frog always jumps a fixed distance, D.

# Count the minimal number of jumps that the small frog must perform to reach its target.

# Write a function:

# def solution(x, y, d)
# that, given three integers X, Y and D, returns the minimal number of jumps from position X to a position
# equal to or greater than Y.

# For example, given:

#   X = 10
#   Y = 85
#   D = 30
# the function should return 3, because the frog will be positioned as follows:

# after the first jump, at position 10 + 30 = 40
# after the second jump, at position 10 + 30 + 30 = 70
# after the third jump, at position 10 + 30 + 30 + 30 = 100
# Write an efficient algorithm for the following assumptions:

# X, Y and D are integers within the range [1..1,000,000,000];
# X ≤ Y.

MIN_VAL = 1
MAX_VAL = 1000000000

def solution(x,y,d)
    raise ArgumentError.new("X, Y, D have to be integers") if !x.is_a? Integer or !y.is_a? Integer or !d.is_a? Integer
    raise ArgumentError.new("x between #{MIN_VAL} and #{MAX_VAL}") if x < MIN_VAL or x > MAX_VAL
    raise ArgumentError.new("y between #{MIN_VAL} and #{MAX_VAL}") if y < MIN_VAL or y > MAX_VAL
    raise ArgumentError.new("d between #{MIN_VAL} and #{MAX_VAL}") if d < MIN_VAL or d > MAX_VAL

    ret = 0

    distance = y-x
    if distance > 0
        ret = distance/d
        ret += 1 if distance%d != 0
    end
    return ret
end

puts solution(1,1,2)
puts solution(30,1,2)
puts solution(1,5,2)
puts solution(1,2,5)

assert_equal(0, solution(1,1,2))
assert_equal(0, solution(30,1,2))
assert_equal(2, solution(1,5,2))
assert_equal(1, solution(1,2,5))
assert_equal(200000000, solution(MIN_VAL,MAX_VAL,5))


assert_raise(ArgumentError.new("X, Y, D have to be integers")) {solution(1,2,'a')}
assert_raise(ArgumentError.new("X, Y, D have to be integers")) {solution(1,'a',3)}
assert_raise(ArgumentError.new("X, Y, D have to be integers")) {solution('a',2,3)}
assert_raise(ArgumentError.new("d between #{MIN_VAL} and #{MAX_VAL}")) {solution(1,2,0)}