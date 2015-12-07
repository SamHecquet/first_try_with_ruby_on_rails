# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  body       :string
#  chef_id    :integer
#  recipe_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.create(chefname: "bob", email: "toto@toto.com", password: "password")
    @recipe = @chef.recipes.create(
                name: "name truc", 
                summary: "summary truc", 
                description: "description truc assez longue ok"
              )
    @review = @chef.reviews.new(recipe: @recipe, body: 'It\'s amazing')
  end
  
  test "Review should be valid" do
    assert @review.valid?, "#{@review.errors.full_messages.to_s}"
    # save to compare
    assert_same @chef.reviews.count, 0
    assert_same @recipe.reviews.count, 0
    @review.save
    assert_same @chef.reviews.count, 1
    assert_same @recipe.reviews.count, 1
  end
  
  test "review body should be present" do
    @review.body = " "
    assert_not @review.valid?
  end
  
  test "review body should not be too long" do
    @review.body = "a" * 501
    assert_not @review.valid?
  end
  
  test "review body should not be too short" do
    @review.body = "a" * 4
    assert_not @review.valid?
  end
  
end
