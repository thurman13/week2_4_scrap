require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pp'

def get_price
	url = "https://coinmarketcap.com/all/views/all/"
	page = Nokogiri::HTML(open(url))

	liste_prix = Hash.new

	#On récupère l'attribut alt des logos plutôt que le texte du titre pour éviter les noms incomplets avec des ... à la fin
	monnaies = page.css('tbody tr')
	monnaies.each do |monnaie|
		#.first permet de convertir le NodeSet XML en élément (il y a juste 1 résultats dans chaque NodeSet)
		nom = monnaie.css("td.currency-name img").first['alt']
		prix = monnaie.css("a.price").text
		liste_prix[nom] = prix
	end
	
	pp liste_prix
	puts liste_prix.size
end

get_price