#!/Users/patrick/.rbenv/shims/ruby

s = "2A2B4C"

sa = s.chars
arr = Array.new
sa.each do |val|
	if val.to_i.to_s == val
		arr.push(val.to_i)
	else
		arr.push(val)
	end
end


puts "#{arr}"