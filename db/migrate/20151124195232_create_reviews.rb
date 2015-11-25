class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :body
      t.integer :chef_id, :recipe_id
    end
  end
end
