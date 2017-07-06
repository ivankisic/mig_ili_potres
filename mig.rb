#/usr/bin/ruby

require 'rss'
require 'twitter'

time = Time.new
danas = time.strftime("%a, %d %b")

def dummy
end

client = Twitter::REST::Client.new do |config|
	config.consumer_key = "key"
	config.consumer_secret = "secret"
	config.access_token = "token"
	config.access_token_secret = "token_secret"
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
        if "#{item.title}".include? "CROATIA"  and "#{item.pubDate}".include? "#{danas}"
                client.update("Potres! - #{item.title}")
        else
                dummy
        end
end

