require 'mechanize'
require 'pry'
require 'uri'

class Camp
	DATE='campingDate'
	LENGTH_NIGHT='lengthOfStay'
	attr_reader :page, :form, :submit, :sites, :name, :total
	def initialize(date,lengh_night=1,camp)
		@sites=[]
		url_setup(camp)
		form_setup
		input_form(date, lengh_night)
		getsites	
	end

	def url_setup(camp)
		url = URI.escape("http://www.reserveamerica.com/camping/san-onofre-sb/r/campgroundDetails.do?contractCode=CA&parkId=#{camp}")
		mechanize = Mechanize.new{ |agent| agent.user_agent_alias = 'Mac Safari'}
		begin	
			@page = mechanize.get(url)
		rescue Mechanize::ResponseCodeError => exception
		  if exception.response_code == '403'
		    @page = exception.page
		  else
		    raise # Some other error, re-raise
		  end
		end
	end

	def form_setup
		@form=@page.forms.first
	end

	def input_form(date, lengh_night)
		@form[DATE] = date
		@form[LENGTH_NIGHT] = lengh_night
	end

	def getsites
		result=@form.submit
		available_sites(result)
	end

	def available_sites(result)
		@name=result.at('#cgroundName').text
		total=result.at('.matchSummary').text
		total=total.match(/\A[\d]+/)
		@total=total[0].to_i		

		if @total >= 10
			@total=10
		end

		sites=result.search('.br')	
		
		
		
		@total.times do |i|		
			site=sites[i].text.strip.split(/\n+/)
			site.delete_at(6) and site.delete_at(2) and site.delete_at(0)

			# Handicap check 
			if sites[i].search('td')[3].children[1]
				site << "Handicap"
			else 
				site << "No Handicap"
			end
			@sites << site
		end		
	end

end