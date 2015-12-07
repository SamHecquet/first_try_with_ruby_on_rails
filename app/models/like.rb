# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  like       :boolean
#  chef_id    :integer
#  recipe_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Like < ActiveRecord::Base
  belongs_to :chef
  belongs_to :recipe
  
  validates_uniqueness_of :chef, scope: :recipe
end
