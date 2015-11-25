class Review < ActiveRecord::Base
  belongs_to :chef
  belongs_to :recipe
  validates :chef_id, presence: true
  validates :recipe_id, presence: true
  validates :body, presence: true, length: { minimum: 5, maximum: 500 }
  default_scope -> { order(created_at: :desc) }
end