module ResumesHelper
	def clipped_url(url)
		edited = url.gsub(/((http)s?:(\/)*)/, '')
		edited = edited.gsub(/(w{3}\.)/, '')

		return edited
	end
end
