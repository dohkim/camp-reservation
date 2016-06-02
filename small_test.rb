require 'mechanize'
require 'pry'
require 'date'
require 'uri'
require_relative 'lib/reservation'

d=Date.new(2016,6,3).strftime('%a %b %d %Y')
FAV = [120085]
a=Reservation.new(d,2,FAV)

# a.show_available