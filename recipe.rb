class Recipe
  attr_reader :title, :prep_time, :cook_time, :description, :difficulty
  attr_accessor :tested

  def initialize(title,
                 prep_time,
                 cook_time,
                 description,
                 difficulty,
                 tested = false
                 )
    @title = title
    @prep_time = prep_time
    @cook_time = cook_time
    @description = description
    @difficulty = difficulty
    @tested = tested
  end

  def tested?
    @tested
  end
end
