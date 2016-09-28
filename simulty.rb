#!/usr/bin/ruby
require 'net/http'

###########################################################################
#                                                                         #
#   Copyright (C) 2015 Wolfgang Hotwagner(wolfgang.hotwagner@toscom.at)	  #
#                                                                         #
#   This program is free software; you can redistribute it                #
#   and/or modify it under the terms of the                               #
#   GNU General Public License as published by the                        #
#   Free Software Foundation; either version 2 of the License,            #
#   or (at your option) any later version.                                #
#                                                                         #
#   This program is distributed in the hope that it will be               #
#   useful, but WITHOUT ANY WARRANTY; without even the implied            #
#   warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR               #
#   PURPOSE. See the GNU General Public License for more details.         #
#                                                                         #
#   You should have received a copy of the GNU General Public             #
#   License along with this program; if not, write to the Free            #
#   Software Foundation, Inc., 51 Franklin St, Fifth Floor,               #
#   Boston, MA 02110, USA                                                 #
#                                                                         #
###########################################################################

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
