# == Schema Information
#
# Table name: ingredients
#
#  id   :integer          not null, primary key
#  name :string
#

class Ingredient < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 2, maximum: 25 }, uniqueness: { case_sensitive: false }
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients
  default_scope -> { order(name: :asc) }
end
