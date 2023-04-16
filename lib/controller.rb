require_relative 'view'
require_relative 'recipe'

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
    # 2. Create a recipe instance
    recipe = Recipe.new(name, description)
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

  private

  def display_recipes
    # 1. Get the recipes from the cookbook
    recipes = @cookbook.all
    # 2. Ask the view to display them
    @view.display(recipes)
  end
end