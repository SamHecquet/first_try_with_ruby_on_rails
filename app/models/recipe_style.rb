# == Schema Information
#
# Table name: recipe_styles
#
#  id        :integer          not null, primary key
#  style_id  :integer
#  recipe_id :integer
#

class RecipeStyle < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :style
      
  validates_uniqueness_of :recipe, scope: :style
end
