require_relative 'view'
require_relative 'recipe'
require_relative 'scrape_allrecipes_service'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    display_recipes
  end

  def add
    # 1. Ask the view to get the name and description of the recipe
    name = @view.ask_for('name')
    description = @view.ask_for('description')
    prep_time = @view.ask_for('prep time')
    rating = @view.ask_for('rating')
    # 2. Create a recipe instance
    recipe = Recipe.new(
      name: name,
      description: description,
      rating: rating,
      prep_time: prep_time
    )
    # 3. Ask the Cookbook to add the recipe
    @cookbook.create(recipe)
  end

  def remove
    # 0. Display the recipes
    display_recipes
    # 1. Ask the view to get the index of the recipe to remove
    index = @view.ask_for_index
    # 2. Delete the recipe from the cookbook
    @cookbook.destroy(index)
  end

  def import
    # keyword = have the view ask the user for a keyword
    keyword = @view.ask_for('keyword')
    # recipes = give the keyword to our scraper, this should give us... recipes (an array of instances)
    recipes = ScrapeAllrecipesService.new(keyword).call
    # tell the view to display the scraped recipes
    @view.display(recipes)
    # index = tell the view to ask user for a number (aka index)
    index = @view.ask_for_index
    # recipe = get one recipe from the array using the index
    recipe = recipes[index]
    # tell the cookbook to create the recipe
    @cookbook.create(recipe)
  end

  def mark_as_done
    display_recipes
    # ask the user which recipe?
    index = @view.ask_for_index
    @cookbook.mark_as_done(index)
    # we need to save
  end

  private

  def display_recipes
    # 1. Get the recipes from the cookbook
    recipes = @cookbook.all
    # 2. Ask the view to display them
    @view.display(recipes)
  end
end
