require 'terminal-table'
require_relative 'camp'
require_relative 'email'
include Email

class Reservation
	attr_reader :camps, :date, :lengh_night

	def initialize(date,lengh_night=1,camps)
		@camps=[]
		@date=date
		camps.each do |camp|
			@camps << Camp.new(date,lengh_night, camp)
		end
	end	

	def show_available
		@camps.each do |camp|
			table=Terminal::Table.new :title=>"Camp : #{camp.name} | Date : #{@date}", :headings=>['Site#','Site type',
				'Max # of people', 'Epuip length', 'Price', 'Accessible'] do |t|
					t.rows = camp.sites
			end			
			puts table
		end
	end

	def alarm
		p "times"	
		@camps.each do |camp|	
			if camp.total > 0
				send_mail(camp.name)
				exit
			end
		end
	end

end