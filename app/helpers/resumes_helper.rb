module ResumesHelper
	def clipped_url(url)
		if url != nil
			edited = url.gsub(/((http)s?:(\/)*)/, '')
			edited = edited.gsub(/(w{3}\.)/, '')
			
			return edited
		else
			return url
		end
	end
end
