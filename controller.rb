require_relative 'repo.rb'
require_relative 'lets_cook_french'
require_relative 'recipe'

class Controller
  def initialize(repo)
    @repo = repo
  end

  def add
    # ask view for recipe
    title = @view.ask_for_title
    prep_time = @view.ask_for_prep_time
    cook_time = @view.ask_for_cook_time
    description = @view.ask_for_description
    difficulty = @view.ask_for_difficulty
    #create recipe
    recipe = Recipe.new(title, prep_time, cook_time, description, difficulty)
    # add to repo
    @repo.add_recipe(recipe)
  end

  def list
    @repo.all
  end

  def delete
    # ask view for recipe to delete
    index = @view.ask_which_recipe_to_delete
    # ask controller to delete
    @repo.delete(index.to_i - 1)
  end

  def import
    # ask view for search term
    search_term = @view.ask_for_search_term
    # import
    recipes_array = Letscookfrench.search_list(search_term)
    # add to repo
    if recipes_array.size == 0
      # ask view to return 0 results
      @view.bad_news
    else
      # ask view to return # of results
      @view.good_news(recipes_array.size)
      # ask view to print list
      @view.print_list_of_searched_recipes(recipes_array)
      # ask view which one to add
      index = @view.which_recipe_to_add.to_i - 1
      # retrieve link
      recipe_to_add = Letscookfrench.retrieve_link(recipes_array[index][:link])
      # create Recipe
      recipe = Recipe.new(recipe_to_add[:title],
                          recipe_to_add[:prep_time],
                          recipe_to_add[:cook_time],
                          recipe_to_add[:description],
                          recipe_to_add[:difficulty]
                          )
      # add to repo
      @repo.add_recipe(recipe)
    end
  end

  def mark_as_tested
    # asks user which recipe to mark as tested
    index = @view.which_recipe_to_mark_as_tested
    # asks repo to update
    @repo.mark_as_tested(index - 1)
  end
end
