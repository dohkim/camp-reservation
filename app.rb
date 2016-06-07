require 'mechanize'
require 'pry'
require 'date'
require 'uri'
require 'chronic'
require_relative 'lib/reservation'
require_relative 'lib/mail'

d=Chronic.parse('this saturday').strftime('%a %b %d %Y')
FAV = [120090, 120083,120085,120082,120070,120025]
a=Reservation.new(d,1,FAV)

a.show_available