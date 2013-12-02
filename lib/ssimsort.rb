#!/usr/bin/env ruby

module SsimSort

	root = File.expand_path("../..", __FILE__)
	require "numeric_array"
	require "#{root}/lib/array.rb"
	require "RMagick"
	require "fileutils"
	include Magick
	
	@formats = /(.jpg$|.png$|.JPG$|.jpeg$|.PNG$|.gif$|.bmp$|.BMP$)/

	def SsimSort.cov(x,y)
		return x.zip(y).covariance
	end


	def SsimSort.get_lum(img,px=80)
		img = img.scale(px,px)
		lum_average = img.get_pixels(0, 0, img.columns, img.rows).map do |p|
			p.to_HSL[2]
		end
		return lum_average
	end


	def SsimSort.ssim(file1,file2)
		cA,cB = 0.01, 0.03
		x,y = get_lum(ImageList.new(file1)), get_lum(ImageList.new(file2))
		var_x, var_y = x.variance, y.variance
		moy_x, moy_y = x.mean, y.mean
		a = (2*moy_x*moy_y+cA)*(2*(cov(x,y))+cB)
		b = (moy_x**2+moy_y**2+cA)*(var_x+var_y+cB)
		(a/b) < 0 ? 0 : (a/b).round(5)
	end

	
	def SsimSort.ssim_dir(input_path)	
		files = Dir.entries(input_path).map {|file| File.absolute_path("#{input_path}/#{file}")}
		files.shift(2) #Remove . and ..
		files.select!{|f| @formats=~ f}
		set = files.product(files)
		set.each do |file1,file2|
			simil = SsimSort.ssim(file1,file2)
			puts "#{file1.split("/").last}\t|\t#{simil}\t|\t#{file2.split("/").last}"  
		end
	end

	def SsimSort.ssim_dir_mean(input_path)
		files = Dir.entries(input_path).map {|file| File.absolute_path("#{input_path}/#{file}")}
		files.shift(2) #Remove . and ..
		files.select!{|f| @formats=~ f}
		set = files.combination(2).to_a
		l = set.map {|file1,file2| SsimSort.ssim(file1,file2)}.mean
	end

	def SsimSort.sort(input_path,output_path,tolerance=0.8)
		files = Dir.entries(input_path).map {|file| File.absolute_path("#{input_path}/#{file}")}
		files.shift(2) #Remove . and ..
		files.select!{|f| @formats=~ f}
		set = files.product(files)
		set.each do |file1,file2|
			path = "#{output_path}/#{file1.split("/").last}/"
			simil = SsimSort.ssim(file1,file2)
			if simil > tolerance
				FileUtils.makedirs(path) unless File.exists?(path)
				FileUtils.cp(file2,path)
			end
		end
	end

	def SsimSort.sort_comp(filecomp_path,input_path,output_path)
		filecomp = File.absolute_path(filecomp_path)
		output_path = File.absolute_path(output_path+"/")
		files = Dir.entries(input_path).map {|file| File.absolute_path("#{input_path}/#{file}")}
		files.shift(2) #Remove . and ..
		files.select!{|f| @formats=~ f}
		sim_dict = {}
		FileUtils.mkdir(output_path) unless File.exists?(output_path)
		files.each do |file|
			simil = SsimSort.ssim(filecomp,file)
			sim_dict[file] = simil	
		end
		sim_list = sim_dict.sort_by {|k,v| v}.reverse
		sim_list.each_with_index do |k,i|
			FileUtils.cp(k[0],"#{output_path}/#{i}(#{k[1]})#{File.extname(k[0])}")
		end
	end

end

