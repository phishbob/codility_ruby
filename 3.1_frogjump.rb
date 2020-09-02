#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
include Test::Unit::Assertions

def solution(x,y,d)
    # """
    # Calculate the miminum number of jumps from X to Y
    # :param X: start integer
    # :param Y: minimum end integer
    # :param D: size of the jump
    # :return: minium number of jumps in O(1) time and space complexity
    # """
    raise ArgumentError.new("X, Y, D have to be integers") if !x.is_a? Integer or !y.is_a? Integer or !d.is_a? Integer
    #raise ArgumentError.new("X has to be smaller than Y") if x >= y ## nowehere requested!!!
    raise ArgumentError.new("D has to be bigger than 0") if d < 1

    distance = y-x
    return 0 if distance <= 0
    ret = distance/d
    remainder = distance%d
    return remainder == 0 ? ret : ret+1

end
puts solution(1,1,2)
puts solution(1,5,2)
puts solution(1,2,5)

assert_raise(ArgumentError.new("X, Y, D have to be integers")) {solution(1,2,'a')}
assert_raise(ArgumentError.new("X, Y, D have to be integers")) {solution(1,'a',3)}
assert_raise(ArgumentError.new("X, Y, D have to be integers")) {solution('a',2,3)}
#assert_raise(ArgumentError.new("X has to be smaller than Y")) {solution(5,2,1)}
#assert_raise(ArgumentError.new("X has to be smaller than Y")) {solution(0,0,0)}
assert_raise(ArgumentError.new("D has to be bigger than 0")) {solution(1,2,0)}