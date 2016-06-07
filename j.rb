require 'mechanize'
require 'pry'
require 'date'
require 'uri'
require_relative 'lib/reservation'

d=Date.new(2016,7,2).strftime('%a %b %d %Y')
FAV = [120070]

loop do
	a=Reservation.new(d,2,FAV)
	a.alarm		
	sleep(300)
end



