require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"

# require_relative 'controller'
require_relative 'repo'
require_relative 'recipe'
require_relative 'lets_cook_french'

set :bind, '0.0.0.0'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

def initialize
  @repo = Repo.new('repo.csv')
end

get '/' do
  # @controller = Controller.new(@repo)
  erb :index
end

get '/list' do
  @list = @repo.all
  erb :list
end

get '/add' do
  erb :add
end

get '/added' do
    recipe = Recipe.new(params[:title],
                        params[:prep_time],
                        params[:cook_time],
                        params[:description],
                        'easy')
    @repo.add_recipe(recipe)
  "Added!!11 <br> <a href='/'>Back</a>"
end

get '/destroy' do
  erb :destroy
end

get '/destroyed' do
  @repo.delete(params[:index].to_i - 1)
  "Destroyed! <br> <a href='/'>Back</a>"
end

get '/search' do
  search_term = params[:search_term]
  @recipes_array = Letscookfrench.search_list(search_term)
  if @recipes_array.size == 0
    'No results'
  else
    erb :search
  end
end

get '/add_from_website' do
  link = params[:link]
  @recipe = Letscookfrench.retrieve_link(link)
  @recipe.to_s
  recipe = Recipe.new(@recipe[:title],
                      @recipe[:prep_time],
                      @recipe[:cook_time],
                      @recipe[:description],
                      'easy')
    @repo.add_recipe(recipe)
  "Added!!11 <br> <a href='/'>Back</a>"
end
