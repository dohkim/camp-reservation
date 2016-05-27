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
d=Date.new(2016,6,7).strftime('%a %b %d %Y')

form = page.forms.first

form['campingDate'] = d
form['lengthOfStay'] = 1
npage=form.submit	
sites=npage.search('.br')
total=npage.at('.matchSummary').text
total=total.match(/\A[\d]+/)
total=total[0].to_i

if total >= 10
	total=10
end
total.times do |i|
	p "total: #{total}"
	site=sites[i].text.strip.split(/\n+/)
	site.delete_at(6) and site.delete_at(0)
	p site
end







