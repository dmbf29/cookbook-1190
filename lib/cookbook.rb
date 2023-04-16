require 'csv'

class Cookbook
  def initialize(csv_file_path)
    @recipes = [] # array of instances of Recipe
    @csv_file_path = csv_file_path

    load_csv
  end

  def all
    @recipes
  end

  def create(recipe)
    @recipes << recipe

    save_csv
  end

  def destroy(recipe_index)
    @recipes.delete_at(recipe_index)

    save_csv
  end

  private

  def load_csv
    # The goal is to populate the @recipes array with recipes (with recipes from the CSV)
    CSV.foreach(@csv_file_path) do |row|
      # row is an array of strings, e.g. ["Apple pie", "Apple with pies"]
      # we need an instance of Recipe to push to the array
      recipe = Recipe.new(row[0], row[1])
      @recipes << recipe
    end
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv_file|
      # csv_file << ['boeuf bourguignon', 'boeuf with bourguignon']
      @recipes.each do |recipe|
        csv_file << [recipe.name, recipe.description]
      end
    end
  end
end
