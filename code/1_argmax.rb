# return A
C = eval(File.open("../output/C.txt", "rb").read)
I = Array.new(1095) { 1 }
A = Array.new() 

K = 8
(1..1095-K).each do |k|
	# find argmax m 
	max = 0
	i = 0
	m = 0
	(1..1095).each do |a|
		(1..1095).each do |b|
			if (C[a-1][b-1] > max) and (a != b) and (I[a-1] == 1) and (I[b-1] == 1) 
				max = C[a-1][b-1]
				i = a
				m = b
			end	
		end
	end

	# puts "<#{i}, #{m}>"

	# append
	if m != 0		
		p A << Array[i, m]
	end

	di = eval(File.open("../input/tf-idf_hash/#{i}.txt", "rb").read)
	dm = eval(File.open("../input/tf-idf_hash/#{m}.txt", "rb").read)
	(1..1095).each do |j|
		dj = eval(File.open("../input/tf-idf_hash/#{j}.txt", "rb").read)

		resultij = 0
		di.keys.each do |key|
			if dj[key] != nil
				resultij = resultij + (di[key]*dj[key])
			end 
		end

		resultmj = 0
		dm.keys.each do |key|
			if dj[key] != nil
				resultmj = resultmj + (dm[key]*dj[key])
			end 
		end

		sim = [resultij, resultmj].max
		C[i-1][j-1] = sim
		C[j-1][i-1] = sim
	end
	I[m-1] = 0
end

# output
f = File.open("../output/A#{K}.txt", 'w')
f.write(A)
f.close()