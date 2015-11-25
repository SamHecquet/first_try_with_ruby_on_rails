class RecipeStyle < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :style
      
  validates_uniqueness_of :recipe, scope: :style
end