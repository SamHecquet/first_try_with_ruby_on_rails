# == Schema Information
#
# Table name: recipe_ingredients
#
#  id            :integer          not null, primary key
#  ingredient_id :integer
#  recipe_id     :integer
#

class RecipeIngredient < ActiveRecord::Base
  belongs_to :recipe  
  belongs_to :ingredient  
    
  validates_uniqueness_of :recipe, scope: :ingredient
end
