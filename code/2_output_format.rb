K = 20
# cluster
A = eval(File.open("../output/A_#{K}.txt", "rb").read)

(1..1095).each do |i|
	A << Hash[i => [i]]
end

cluster1 = Hash.new

A.each do |hash|

	if cluster1.has_key?(hash.keys.first)
		cluster1[hash.keys.first] << hash.values.first
	else
		cluster1[hash.keys.first] = Array[hash.values.first]
	end
end
# p cluster1

(1..3).each do 
	cluster1.each do | key, value |
		cluster1.keys.each do |k|
			if value.include?(k)
				cluster1[ [k,key].min ] = cluster1[k]+cluster1[key]
				cluster1.delete([k,key].max)
			end
		end
	end
end
# p cluster1

# output
f = File.open("../output/#{K}.txt", 'w')
cluster1.each do | key, value |
	value.flatten.sort.uniq.each do |d|
		f.write("#{d}\n")
	end
	f.write("\n")
end
f.close()


