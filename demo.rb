require 'nokogiri'
require 'httparty'
require 'rubygems'
require 'open-uri'

class Scrapp
  def initialize
    @all_category = []
    @all_recipes  =[]
    # @doc = getHtml("https://www.allrecipes.com")
    @doc = Nokogiri::HTML(open("https://www.allrecipes.com/"))
    categories
    parse_recipes

  end

  def categories
    puts 'get categories'
    categoryName = @doc.to_html.scan(/<span class=\"category-title\" data-ellipsis>(.*)<\/span>/)
    category_link =  @doc.to_html.scan(/<a\s*data-internal-referrer-link=\"top\s*hubs\"\s*href=\"(.*?)\"/)
    category_names = []
    @category_links = []

    categoryName.each do |cat_name|
            category_names.push(cat_name)
    end

    category_link.each do |cat_link|
        @category_links.push(cat_link)
    end

    category_names.each_with_index do |cat_name,index|
      rec_hash ={
                  name: cat_name,
                  link: @category_links[index]
                }
      @all_category.push(rec_hash)
    end

    puts @all_category
    parse_recipes
  end

  def parse_recipes
    @all_category.each do |i|
        puts i[:link]
      cat_link = Nokogiri::HTML(open(i[:link].join("")))
      # cat_links = cat_link.join("")
      rec_name = cat_link.to_html.scan(/<span class="fixed-recipe-card__title-link">(.*)<\/span>/)
      rec_link = cat_link.to_html.scan(/<h3\s*class=\"fixed-recipe-card__h3\">\s*<a\s*href=\"(.*?)\"/)
      rec_names = []
      rec_links = []
      i = 0
      j = 0
      # puts rec_name
      rec_name.each do |rname|
        puts rname
        if i <= 9
            rec_names.push(rname)
            i = i + 1
        end
      end
      puts rec_names

      rec_link.each do |link|
        if j <= 9
          rec_link.push(link)
          j = j + 1
        end
      end
      puts rec_link

      rec_names.each_with_index do |rname ,index|
        rec_hash = {
                    name: rname,
                    link: rec_links[index]
                    }
                    @all_recipes.push(rec_hash)
      end
    end
    puts @all_recipes
  end

def recipe_info
  puts recipe_info


end


  def getHtml(url)
      HTTParty.get(url)
  end
end
srap = Scrapp.new







