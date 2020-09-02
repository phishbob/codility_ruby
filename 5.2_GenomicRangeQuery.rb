#!/Users/patrick/.rbenv/shims/ruby

# A DNA sequence can be represented as a string consisting of the letters A, C, G and T,
# which correspond to the types of successive nucleotides in the sequence. Each nucleotide has an
# impact factor, which is an integer. Nucleotides of types A, C, G and T have impact factors
# of 1, 2, 3 and 4, respectively. You are going to answer several queries of the form:
# What is the minimal impact factor of nucleotides contained in a particular part of the given DNA sequence?

# The DNA sequence is given as a non-empty string S = S[0]S[1]...S[N-1] consisting of N characters.
# There are M queries, which are given in non-empty arrays P and Q, each consisting of M integers.
# The K-th query (0 ≤ K < M) requires you to find the minimal impact factor of nucleotides contained
# in the DNA sequence between positions P[K] and Q[K] (inclusive).

# For example, consider string S = CAGCCTA and arrays P, Q such that:
#     P[0] = 2    Q[0] = 4
#     P[1] = 5    Q[1] = 5
#     P[2] = 0    Q[2] = 6

# The answers to these M = 3 queries are as follows:
# The part of the DNA between positions 2 and 4 contains nucleotides G and C (twice), whose impact
# factors are 3 and 2 respectively, so the answer is 2.
# The part between positions 5 and 5 contains a single nucleotide T, whose impact factor is 4, so the answer is 4.
# The part between positions 0 and 6 (the whole string) contains all nucleotides, in particular nucleotide A whose
# impact factor is 1, so the answer is 1.

# Write a function:
# def solution(s, p, q)
# that, given a non-empty string S consisting of N characters and two non-empty arrays P and Q consisting of M integers,
# returns an array consisting of M integers specifying the consecutive answers to all queries.

# Result array should be returned as an array of integers.

# For example, given the string S = CAGCCTA and arrays P, Q such that:
#     P[0] = 2    Q[0] = 4
#     P[1] = 5    Q[1] = 5
#     P[2] = 0    Q[2] = 6
# the function should return the values [2, 4, 1], as explained above.

# Write an efficient algorithm for the following assumptions:

# N is an integer within the range [1..100,000];
# M is an integer within the range [1..50,000];
# each element of arrays P, Q is an integer within the range [0..N − 1];
# P[K] ≤ Q[K], where 0 ≤ K < M;
# string S consists only of upper-case English letters A, C, G, T.



require "test/unit/assertions"
include Test::Unit::Assertions

NUCLEOTIDES = 'ACGT'
NUC_IMP = {'A' => 1, 'C' => 2, 'G' => 3, 'T' => 4}
NUC_LEN_MIN = 1
NUC_LEN_MAX = 100000
ARR_LEN_MIN = 1
ARR_LEN_MAX = 50000

def solution(s,p,q)
	# checks here
	s.each_char do |e|
		raise ArgumentError.new("string only allows ACGT") unless NUCLEOTIDES.include? e
	end
	s_len = s.length
	raise ArgumentError.new("string between #{NUC_LEN_MIN} and #{NUC_LEN_MAX}") if s.length > NUC_LEN_MAX

	raise ArgumentError.new("p and q have to be non-empty arrays") if !p.is_a? Array or p.empty? or !q.is_a? Array or q.empty?
	raise ArgumentError.new("p and q have to be equal in length") if p.length != q.length
	p_sort = p.sort
	raise ArgumentError.new("p has to be between 0 and #{s_len-1}") if p_sort.first < 0 or p_sort.last >= s_len
	q_sort = q.sort
	raise ArgumentError.new("q has to be between 0 and #{s_len-1}") if q_sort.first < 0 or q_sort.last >= s_len

	p.each_with_index do |elem, idx|
		#puts "p[#{idx}] : #{elem} , q[#{idx}] : #{q[idx]}"
		raise ArgumentError.new("p[i] has to be >= q[i]")  if elem > q[idx]
	end

	## checks END

	### code starts here
	ret = Array.new

	p.each_with_index do |elem, idx|
		min_impact = nil

		## getting substring
		sub_chain = s[elem..q[idx]]
		#puts "sub = #{sub_chain}"

		sub_chain.each_char do |c|
			if min_impact.nil? or min_impact > NUC_IMP[c]
				#puts "NUC_IMP[#{c}] => #{NUC_IMP[c]}"
				min_impact = NUC_IMP[c]
			end
		end
		ret.push(min_impact)

	end

	#puts "ret => #{ret}"
	return ret
end



#solution("ACCGT", [0,1,3], [1,4,3])
#solution("CAGCCTA", [2,5,0], [4,5,6])



#solution("ACACACACACACACACACAC", [1], [2])

assert_raise(ArgumentError.new("string only allows ACGT")){solution("ABC", [1], [1])}
assert_raise(ArgumentError.new("string only allows ACGT")){solution("AC1", [1], [1])}
assert_raise(ArgumentError.new("string between #{NUC_LEN_MIN} and #{NUC_LEN_MAX}")) {solution("A"*(NUC_LEN_MAX+1), [1], [1])}


assert_raise(ArgumentError.new("p and q have to be non-empty arrays")){solution("AC", 1, [1])}
assert_raise(ArgumentError.new("p and q have to be non-empty arrays")){solution("AC", [], [1])}
assert_raise(ArgumentError.new("p and q have to be non-empty arrays")){solution("AC", [1], 1)}
assert_raise(ArgumentError.new("p and q have to be non-empty arrays")){solution("AC", [1], [])}
assert_raise(ArgumentError.new("p and q have to be equal in length")){solution("AC", [1,2], [1])}

assert_raise(ArgumentError.new("p has to be between 0 and 2")){solution("ACC",[1,3], [1,2])}
assert_raise(ArgumentError.new("p has to be between 0 and 2")){solution("ACC",[-1,1], [1,2])}
assert_raise(ArgumentError.new("q has to be between 0 and 2")){solution("ACC",[1,2], [1,4])}
assert_raise(ArgumentError.new("q has to be between 0 and 2")){solution("ACC",[1,2], [-1,1])}
assert_raise( ArgumentError.new("p[i] has to be >= q[i]")){solution("ACC",[1,2], [2,0])}

assert_equal([1,2,3],solution("ACCGT", [0,1,3], [1,4,3]))
assert_equal([2,4,1],solution("CAGCCTA", [2,5,0], [4,5,6]))