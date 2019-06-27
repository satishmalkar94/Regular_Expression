
require 'nokogiri'
require 'httparty'
require 'sqlite3'

begin

    db = SQLite3::Database.new ":memory:"
    puts db.get_first_value 'SELECT SQLITE_VERSION()'

rescue SQLite3::Exception => e

    puts "Exception occurred"
    puts e

ensure
    db.close if db
end

class Scrapp

def initialize
@doc = getHtml("https://www.allrecipes.com")
end

def execute
 categories = getcategories(@doc)
 puts categories
end


def getcategories(htmlcode)
  # categoryNames1 = htmlcode.scan(/(?m)<div\sid=\"insideScroll\"\sclass=\"grid\sslider\">(.*)<\/div>/)

  categoryName2 =htmlcode.scan(/<span class=\"category-title\" data-ellipsis>(.*)<\/span>/)



end

def getHtml(url)
    HTTParty.get(url)
end

end
srap = Scrapp.new
srap.execute


