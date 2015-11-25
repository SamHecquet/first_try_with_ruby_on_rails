require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.create(chefname: "bob", email: "toto@toto.com", password: "password")
    @recipe = @chef.recipes.create(
                name: "name truc", 
                summary: "summary truc", 
                description: "description truc assez longue ok"
              )
    @like = @chef.likes.build(recipe: @recipe)
  end
  
  test "Like should be valid" do
    assert @like.valid?, "#{@like.errors.full_messages.to_s}"
  end
  
    
  test "Like should be unique" do
    @like.save
    like = @recipe.likes.create(chef: @chef)
    assert_not like.valid?
    
    like2 = @chef.likes.create(recipe: @recipe)
    assert_not like2.valid?
  end
  
end