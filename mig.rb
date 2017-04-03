#/usr/bin/ruby

require 'rss'
require 'twitter'

time = Time.new
danas = time.strftime("%a, %d %b")
=begin
migovi = [
	"Izgleda da je MIG. MORH je najavio vježbe",
	"Jep, MIG-ovi su. Iz MORH-a su najavili letove",
	"Lokalni 'poduzetnikov' BMW i dalje živi, ipak je MIG",
	"Kvartovske plinske instalacije još stoje, bio je MIG"
]
=end

def dummy
end

client = Twitter::REST::Client.new do |config|
	config.consumer_key = "yDFpTfNvtM1Bf3UFkBYu9Sbah"
	config.consumer_secret = "IkJGDAOSmKZZ3w1qTdY0XhAAtaR4oaIsId7he55Q7la0k7cAuk"
	config.access_token = "849015072785670148-BY5jUcosLpEdVLQ2rzJ7mW8Zz2c3ptz"
	config.access_token_secret = "1AgfdwEchwxWzA96lSAlt0nQkhDnv4lfizxQDHUH19FLY"
end

rss_mig = RSS::Parser.parse('https://www.morh.hr/hr/vijesti-najave-i-priopcenja/priopcenja.feed?type=rss', false)

rss_mig.items.each do |item|
	if "#{item.title}".include? "Letačke"  and "#{item.pubDate}".include? "#{danas}"
		client.update("Mig je! - #{item.link}")
	else
		dummy
	end
end

rss_potres = RSS::Parser.parse('http://www.emsc-csem.org/service/rss/rss.php?typ=emsc&min_lat=10&min_long=-30&max_long=65', false)

rss_potres.items.each do |item|
        if "#{item.title}".include? "TURKEY"  and "#{item.pubDate}".include? "#{danas}"
                client.update("Potres! - #{item.title}")
        else
                dummy
        end
end

