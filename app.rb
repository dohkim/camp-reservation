require 'mechanize'
require 'pry'
require 'date'
require 'uri'

uri = URI.escape("http://www.reserveamerica.com/camping/san-onofre-sb/r/campgroundDetails.do?contractCode=CA&parkId=120085")
mechanize = Mechanize.new{ |agent| agent.user_agent_alias = 'Mac Safari'}
begin	
	page = mechanize.get(uri)
rescue Mechanize::ResponseCodeError => exception
  if exception.response_code == '403'
    page = exception.page
  else
    raise # Some other error, re-raise
  end
end
d=Date.new(2016,5,28).strftime('%a %b %d %Y')

form = page.forms.first
binding.pry
form['locationCriteria'] = 120082
form['interest'] = 'camping'
form['lookingFor'] = 2003
form['campingDate'] = d
form['lengthOfStay'] = 1
new=form.submit	
# binding.pry
p new



