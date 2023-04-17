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

  def mark_as_done(index)
    recipe = @recipes[index]
    recipe.mark!

    save_csv
  end

  private

  def load_csv
    # The goal is to populate the @recipes array with recipes (with recipes from the CSV)
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      # we need to convert any non-strings before creating the instance
      # row is a hash of strings, e.g. { name: "Apple pie", description: "Apple with pies" }
      # p recipe = Recipe.new(row[0], row[1]....)
      # we need an instance of Recipe to push to the array
      # when we create the instance, we need a

      # reassigning what's inside of the :done
      row[:done] = row[:done] == "true"
      recipe = Recipe.new(row)
      @recipes << recipe
    end
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv_file|
      # csv_file << ['boeuf bourguignon', 'boeuf with bourguignon']
      csv_file << ['name', 'description', 'rating', 'prep_time', 'done']
      @recipes.each do |recipe|
        csv_file << [recipe.name, recipe.description, recipe.rating, recipe.prep_time, recipe.done?]
      end
    end
  end
end
