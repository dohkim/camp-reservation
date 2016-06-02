require 'mechanize'
require 'pry'
require 'date'
require 'uri'
require_relative 'lib/reservation'

d=Date.new(2016,7,2).strftime('%a %b %d %Y')
FAV = [120090, 120083,120085,120082,120070,120025]
a=Reservation.new(d,2,FAV)

a.show_available