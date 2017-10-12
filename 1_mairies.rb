require 'rubygems'
require 'nokogiri'
require 'open-uri' 


def get_the_email_of_a_townhal_from_its_webpage(page_url)
	page = Nokogiri::HTML(open(page_url))

	reg = /.+@.+\.\w+/

	adresse = page.css('td.style27 p.Style22').select do |elt|
		elt.text.match?(reg)
	end

	adresse.join("")[1..-1]
end

def get_all_the_emails_of_val_doise_townhalls
	page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))

	page.css("a.lientxt").each_with_object(Hash.new(0)) do |townhall, hash|
		town_name = townhall.text
		link = "http://annuaire-des-mairies.com" + townhall['href'][1..-1]
		email = get_the_email_of_a_townhal_from_its_webpage(link)
		hash[town_name] = email
	end

end

puts get_all_the_emails_of_val_doise_townhalls