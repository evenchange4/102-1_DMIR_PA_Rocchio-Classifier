# 輸出 二維array C 
C = Array.new(1095) { Array.new(1095) }

(1..1095).each do |n|
	d1 = eval(File.open("../input/tf-idf_hash/#{n}.txt", "rb").read)
	(1..1095).each do |i|
		d2 = eval(File.open("../input/tf-idf_hash/#{i}.txt", "rb").read)
		result = 0
		d1.keys.each do |key|
			if d2[key] != nil
				result = result + (d1[key]*d2[key])
			end 
		end
		C[n-1][i-1] = result
	end	
	p "=====C[#{n-1}]====="
	# p C[n-1]
end

# output
f = File.open("../output/C.txt", 'w')
f.write(C)
f.close()