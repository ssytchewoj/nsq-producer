require 'json'
require 'uuidtools'

class Generator
	def initialize intensity = 1, count = 4
		@intensity = intensity
		@acc = Random.rand(intensity)
		@count = count

		@videos = Array.new(count) { |i| { video_id: UUIDTools::UUID.timestamp_create.to_s }.to_json }
	end

	def generate!
		@acc += 1
		if @acc > @intensity
			@acc = 0
			@videos[Random.rand(@count)]
		else
			nil
		end
	end
end