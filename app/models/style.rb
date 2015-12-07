# == Schema Information
#
# Table name: styles
#
#  id   :integer          not null, primary key
#  name :string
#

class Style < ActiveRecord::Base
  has_many :recipe_styles
  has_many :recipes, through: :recipe_styles
  validates :name, presence: true, length: { minimum: 2, maximum: 25 }, uniqueness: { case_sensitive: false }
  default_scope -> { order(name: :asc) }
end
