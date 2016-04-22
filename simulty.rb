#!/usr/bin/ruby
require 'net/http'

class Simulty
	@@ary
	@threads

	def initialize(logfile)
		@@ary = Array.new
		
		file = File.open(logfile,"r")

		while( f = file.gets) 
  			f.each_line do |line|
      				@@ary.push(line)
  			end
		end
		file.close
	end

	def wwwget

		uri = URI(@@ary[Random.new.rand(0...@@ary.length)])
		puts uri
		Net::HTTP.get(uri)
	end

	def runtest(numthreads)
		i = 0

		at_exit do
			@threads.each do |x|
			x.kill
			end
			exit 0
		end


		begin
		while(1 == 1)
			@threads = []
			for i in 0..numthreads
				@threads << Thread.new { self.wwwget }
			end
#			puts "joining\n"
			@threads.each { |thr| thr.join }
		end
		rescue Exception => e
		   if e.inspect != "Interrupt"
		    puts "EXCEPTION: #{e.inspect}"
		    puts "MESSAGE: #{e.message}"
		   end
		end
	end

end

if ARGV.length != 2
	puts "usage: #{$PROGRAM_NAME} <logfile> <number-of-threads>"
	exit 1
end

sim = Simulty.new(ARGV[0])
sim.runtest(ARGV[1].to_i)
