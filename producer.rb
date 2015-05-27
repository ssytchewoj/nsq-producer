#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'

Bundler.setup(:default)

require 'nsq'
require './generator.rb'

trap("INT") { 
	puts "Shutting down."
	exit
}

generators = []
# Normal videos
20.times do 
	generators << Generator.new
end

# "cold" videos
generators << Generator.new(40, 6)
generators << Generator.new(55, 2)
generators << Generator.new(45, 3)
generators << Generator.new(60, 4)
generators << Generator.new(50, 5)

producer = Nsq::Producer.new(
  nsqd: '127.0.0.1:4150',
  topic: 'play-events'
)

total_produced = 0

while total_produced < 100000 do
	messages = []

	generators.each do |g|
		result = g.generate!
		messages << result if result
	end

	messages.each do |message|
		producer.write message
		total_produced += 1

		if total_produced % 1000 == 0
			puts "#{DateTime.now} - #{total_produced} events sent"
		end
	end
	sleep 0.02
end
