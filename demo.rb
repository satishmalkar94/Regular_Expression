
require 'nokogiri'
require 'httparty'

class Scrapp

def initialize
@doc = getHtml("https://www.allrecipes.com")
end

def execute
 categories = getcategories(@doc)
 puts categories
end


def getcategories(htmlcode)
  categoryNames1 = htmlcode.scan(/(?m)<div id="insideScroll"class=\"grid slider\">(.*?)<\/div>/)
  categoryName2 =htmlcode.scan(/<span class=\"category-title\" data-ellipsis>(.*)<\/span>/)

end


def getHtml(url)
    HTTParty.get(url)
end

end
srap = Scrapp.new
srap.execute