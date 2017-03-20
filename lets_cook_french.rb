require 'nokogiri'
require 'open-uri'

class Letscookfrench
  def self.search_list(search_term)
    recipes_array = []
    url = "http://www.letscookfrench.com/recipes/find-recipe.aspx?aqt=" + search_term
    doc = Nokogiri::HTML(open(url), nil, 'utf-8')

    doc.css('.m_contenu_resultat').each do |recipe|
      recipe_hash = {}
      recipe_hash[:title] = recipe.css('.m_titre_resultat a').text
      recipe_hash[:link] = recipe.css('.m_titre_resultat a').map {|link| link['href'].to_s}[0]
      recipes_array << recipe_hash
    end
    return recipes_array
  end

  def self.retrieve_link(link)
    url = "http://www.letscookfrench.com/" + link
    doc = Nokogiri::HTML(open(url), nil, 'utf-8')
    title = doc.css('.m_title .item .fn').text
    prep_time = doc.css('.preptime').text.gsub(/ /,"")
    cook_time = doc.css('.cooktime').text.gsub(/ /,"")
    description = doc.css('.m_content_recette_todo').text.gsub(/\s+/, " ").strip
    difficulty = doc.css('.m_content_recette_breadcrumb').text.split(" ")[0]
    return {
              title: title,
              prep_time: prep_time,
              cook_time: cook_time,
              description: description,
              difficulty: difficulty
           }
  end
end
