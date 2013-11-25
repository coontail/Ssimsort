class Array

	def covariance
		sx, sy, sp = 0.0, 0.0, 0.0
		return sx if empty?
	target = first.respond_to?(:to_ary) ? self :
	self.class.new(size) { |i| [i + 1, at(i)] }
	target.each { |x, y|
		sx += x
		sy += y
		sp += x * y
	}
	(sp - sx * sy / size) / size
	end

end
