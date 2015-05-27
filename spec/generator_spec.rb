require 'spec_helper'

describe Generator do
	it "could be created" do
		expect {
			Generator.new
		}.not_to raise_error
	end

	context "hot generator" do
		before :each do
			@generator = Generator.new 3, 1
		end

		it 'should return from 1 to 2 values after 5 calls' do
			messages = []

			5.times do
				result = @generator.generate!
				messages << result if result
			end

			expect(messages.count).to be > 0
			expect(messages.count).to be < 3
		end
	end

	context "multiple videos" do
		before :each do
			@generator = Generator.new 2, 10
		end

		it 'should return 10 different videos' do
			messages = []

			200.times do
				result = @generator.generate!
				messages << result if result
			end

			expect(messages.uniq.count).to eq(10)
		end
	end
end