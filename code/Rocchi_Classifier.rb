# Rocchio classification p.12 Algorithm

#### training phase ####
train_U = Hash.new      # centroid of each class
train_docs = Array.new  # training docs' id set
# each train class
File.open("../data/training.txt", 'rb').each do |l1|
	tmp1 = l1.split(" ")
	clas = tmp1[0]
	docs = tmp1.drop(1)

	puts ">> training phase @ class #{clas}"

	centroid = Hash.new
	# each docs
	docs.each do |d|
		train_docs << d.to_i
		# sum of each vector
		File.open("../data/vector_doc/#{d}.txt", "rb").each_with_index do |l2, i|
			if i > 0 
				tmp2 = l2.split("\t")
				doc_k = tmp2[0]
				doc_v = tmp2[1].strip!.to_f
				if centroid.has_key?(doc_k)
					centroid[doc_k] += doc_v
				else
					centroid[doc_k] = doc_v
				end
			end
		end
	end

	## 除 docs 長度
	centroid.each do |k, v|
		centroid[k] = v / 15
	end

	train_U[clas] = centroid
end


#### testing phase ####
output = File.open("../output.txt", 'w')
output << "doc_id\tclass_id\n"

test_docs = (1..1095).to_a - train_docs
# each docs
test_docs.each do |i|
	puts ">> testing phase @ doc #{i}"
	argmin_class = Array.new(13, 0)

	length_doc = 0
	# each vector
	File.open("../data/vector_doc/#{i}.txt", 'rb').each_with_index do |l, i|
		if i > 0 
			temp = l.split("\t")
			doc_k = temp[0]
			doc_v = temp[1].strip!.to_f

			# length of testing doc
			length_doc += doc_v ** 2

			# each clas
			(1..13).each do |c|
				if train_U[c.to_s].has_key?(doc_k)
					# puts "class #{c} ,key #{doc_k} => #{train_U[c.to_s][doc_k]}"
					argmin_class[c-1] += (train_U[c.to_s][doc_k] - doc_v) ** 2
					# argmin_class[c-1] += (train_U[c.to_s][doc_k] * doc_v)
				else
				end
			end
		end
	end

	# argmin_class.each_with_index do |v ,i|
	# 	argmin_class[i] = v / (Math.sqrt(length_doc)*length_train_U[(i+1).to_s])
	# end

	p argmin_class
	test_result = argmin_class.index(argmin_class.min)+1
	output << "#{i}\t#{test_result}\n" 
end

