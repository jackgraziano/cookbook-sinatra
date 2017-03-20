require 'csv'

class Repo
  def initialize(csv_file)
    @recipes = []
    @csv_file = csv_file
    load_from_csv
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_to_csv
  end

  def all
    @recipes
  end

  def delete(index)
    @recipes.delete_at(index)
    save_to_csv
  end

  def mark_as_tested(index)
    @recipies[index].tested = true
    save_to_csv
  end

  private

  def load_from_csv
    CSV.foreach(@csv_file, {col_sep: ",", quote_char: "\""}) do |row|
      @recipes << Recipe.new(row[0], row[1], row[2], row[3], row[4], row[5])
    end
  end

  def save_to_csv
    CSV.open(@csv_file, "wb") do |csv|
      @recipes.each do |recipe|
        csv << [recipe.title, recipe.prep_time, recipe.cook_time, recipe.description, recipe.difficulty, recipe.tested]
      end
    end
  end

end
