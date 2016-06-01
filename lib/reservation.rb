require 'terminal-table'
require_relative 'camp'

class Reservation
	attr_reader :camps, :date, :lengh_night

	def initialize(date,lengh_night=1,camps)
		@camps=[]
		camps.each do |camp|
			@camps << Camp.new(date,lengh_night, camp)
		end
	end	

	def show_available
		@camps.each do |camp|
			table=Terminal::Table.new :title=>camp.name, :headings=>['Site#','Site type',
				'Max # of people', 'Epuip length', 'Price'] do |t|
					t.rows = camp.sites
			end
			puts table
		end
	end

end