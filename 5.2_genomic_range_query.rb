#!/Users/patrick/.rbenv/shims/ruby

require "test/unit/assertions"
include Test::Unit::Assertions


# score 62% - correctness 100%, performance 0%

# A DNA sequence can be represented as a string consisting of the letters A, C, G and T, which correspond to the types of
# successive nucleotides in the sequence. Each nucleotide has an impact factor, which is an integer.
# Nucleotides of types A, C, G and T have impact factors of 1, 2, 3 and 4, respectively. You are going to answer several
# queries of the form: What is the minimal impact factor of nucleotides contained in a particular part of the given DNA sequence?

# The DNA sequence is given as a non-empty string S = S[0]S[1]...S[N-1] consisting of N characters. There are M queries,
# which are given in non-empty arrays P and Q, each consisting of M integers. The K-th query (0 ≤ K < M) requires you to find
# the minimal impact factor of nucleotides contained in the DNA sequence between positions P[K] and Q[K] (inclusive).

# For example, consider string S = CAGCCTA and arrays P, Q such that:
#     P[0] = 2    Q[0] = 4
#     P[1] = 5    Q[1] = 5
#     P[2] = 0    Q[2] = 6

# The answers to these M = 3 queries are as follows:

#         The part of the DNA between positions 2 and 4 contains nucleotides G and C (twice), whose impact
# 				factors are 3 and 2 respectively, so the answer is 2.
#         The part between positions 5 and 5 contains a single nucleotide T, whose impact factor is 4, so the answer is 4.
#         The part between positions 0 and 6 (the whole string) contains all nucleotides, in particular nucleotide A whose
# 				impact factor is 1, so the answer is 1.

# Write a function:

#     def solution(s, p, q)

# that, given a non-empty string S consisting of N characters and two non-empty arrays P and Q consisting of M integers,
# returns an array consisting of M integers specifying the consecutive answers to all queries.

# Result array should be returned as an array of integers.

# For example, given the string S = CAGCCTA and arrays P, Q such that:
#     P[0] = 2    Q[0] = 4
#     P[1] = 5    Q[1] = 5
#     P[2] = 0    Q[2] = 6

# the function should return the values [2, 4, 1], as explained above.

# Write an efficient algorithm for the following assumptions:

#         N is an integer within the range [1..100,000];
#         M is an integer within the range [1..50,000];
#         each element of arrays P, Q is an integer within the range [0..N − 1];
#         P[K] ≤ Q[K], where 0 ≤ K < M;
#         string S consists only of upper-case English letters A, C, G, T.

#NUCLEOTIDES = 'ACGT'
NUC_IMP = {'A' => 1, 'C' => 2, 'G' => 3, 'T' => 4}
MIN = 1
MAX_N = 100000
MAX_M = 50000

## slow solution
def solution(s,p,q)
	raise ArgumentError.new("s min length is #{MIN}, max length is #{MAX_N}") if s.length > MAX_N or s.length < MIN
	raise ArgumentError.new("p non non-empty array of max #{MAX_M}") if !p.is_a? Array or p.empty? or p.length > MAX_M
	raise ArgumentError.new("q non non-empty array of max #{MAX_M}") if !q.is_a? Array or q.empty? or q.length != p.length

	genom = Array.new #(s.length,1)
	s.each_char do |c|
		raise ArgumentError.new("s can only contain A,C,G,T") unless ["A","C","G","T"].include? c
		if c == 'A'
			val = 1
		elsif c == 'C'
			val = 2
		elsif c == 'G'
			val = 3
		else
			val  = 4
		end
		genom.push(val)
	end

	puts "created genom array"
	ret = Array.new(p.length, 0)
	(0...p.length).each do |i|
		raise ArgumentError.new("p and q may only contain integers") if !p[i].is_a? Integer or !q[i].is_a? Integer
		raise ArgumentError.new("p val #{p[i]} has to be <= than q val #{q[i]}") if p[i] > q[i]
		puts "counter = #{i}" if i % 1000 == 0
		min = nil

		genom[p[i]..q[i]].each do |elem|
			min = elem if min.nil? or elem < min
		end

		ret[i] = min
	end

	return ret
end


s = "CAGCCTA"
p = [2,5,0]
q = [4,5,6]

puts solution(s,p,q).inspect
# a = [0,1,2,3,4,5]
# puts solution(s,[0,1,2,3,4,5,6],[0,1,2,3,4,5,6]).inspect
# assert_raise(ArgumentError.new("p non non-empty array of max 50000")){solution(s,[],q)}
# assert_raise(ArgumentError.new("p non non-empty array of max 50000")){solution(s,Array.new(MAX_M+1,1),q)}
# assert_raise(ArgumentError.new("q non non-empty array of max 50000")){solution(s,p,[])}
# assert_raise(ArgumentError.new("q non non-empty array of max 50000")){solution(s,p,Array.new(MAX_M+1,1))}
# assert_raise(ArgumentError.new("q non non-empty array of max 50000")){solution(s,p,[1,2])}
# assert_raise(ArgumentError.new("s can only contain A,C,G,T")){solution("CAGCCTAl",p,q)}


s = "CA"*(MAX_N/4)
p = Array.new(MAX_M/10) { |i| i  }
q = Array.new(MAX_M/10, MAX_N)
solution(s,p,q)
puts "lala"
