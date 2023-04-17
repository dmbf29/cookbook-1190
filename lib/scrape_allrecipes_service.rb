require "nokogiri"
require "open-uri"

class ScrapeAllrecipesService
  attr_reader :keyword

  def initialize(keyword)
    @keyword = keyword
  end

  def call
    url = "https://www.allrecipes.com/search?q=#{keyword}"
    html = URI.open(url)
    doc = Nokogiri::HTML.parse(html, nil, "utf-8")
    # we need to search for....
    # we are iterating over the cards for recipes
    doc.search('.mntl-card-list-items').first(5).map do |element|
      # we need to find the href for this element
      url = element.attributes['href'].value
      # open the URL with open-url => URI.open(url)
      html = URI.open(url)
      # give the html to Nokogiri
      recipe_doc = Nokogiri::HTML.parse(html, nil, "utf-8")
      # search through the Nokogiri objects
      # we need a name =
      name = recipe_doc.search('h1').text.strip
      # we need a description =
      description = recipe_doc.search('.article-subheading').text.strip
      rating = recipe_doc.search('.mntl-recipe-review-bar__rating').text.strip
      prep_time = recipe_doc.search('.mntl-recipe-details__value').first.text.strip
      # Create an instance of a Recipe
      Recipe.new(
        name: name,
        description: description,
        rating: rating,
        prep_time: prep_time
      )
    end
    # p doc.search('.mntl-card-list-items').count
    # p doc.search('a').count
  end

  # Nokogiri methods
  # classes -> need a dot in front
  # p doc.search('.card__title-text')
  # html_elements
  # p doc.search('h1')
  # ids
  # p doc.search('#mntl-card-list-items_1-0')

  # doc.text

  # element.attributes # => hash of attributes
end


# where should i be running this scraper?
# the controller will call this method
# what should this method return? => an array of 5 INSTANCES of recipes
# when your controller is ready... comment this line out 👇

# Goal:
# download the html
# run this file on its own
# make sure it's returning an array of instances
# ScrapeAllrecipesService.new('strawberry').call # => an array of 5 INSTANCES of recipes
