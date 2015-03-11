module Ssimsort
	module Config

		VERSION = "0.3.0"

		DEFAULT_FORMATS = /(.jpg$|.png$|.JPG$|.jpeg$|.PNG$|.gif$|.bmp$|.BMP$)/
		ALLOWED_FORMATS = nil # Your custom formats

		def self.allowed_formats
 			ALLOWED_FORMATS || DEFAULT_FORMATS
		end

	end
end