# == Schema Information
#
# Table name: recipe_styles
#
#  id        :integer          not null, primary key
#  style_id  :integer
#  recipe_id :integer
#

require 'test_helper'

class RecipeStyleTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.create(chefname: "bob", email: "toto@toto.com", password: "password")
    @style = Style.create(name: "Chicken")  
    @recipe = @chef.recipes.create(
                name: "name truc", 
                summary: "summary truc", 
                description: "description truc assez longue ok"
              )
    @recipeStyle = @style.recipe_styles.new(recipe: @recipe)
  end
  
  test "RecipeStyleTest Setup should be valid" do
    assert @chef.valid?
    assert @style.valid?
    assert @recipe.valid?
  end
  
  test "RecipeStyle should be valid" do
    assert @recipeStyle.valid?, "#{@recipeStyle.errors.full_messages.to_s}"
    # save to compare
    assert_same @style.recipes.count, 0
    assert_same @recipe.styles.count, 0
    @recipeStyle.save
    assert_same @style.recipes.count, 1
    assert_same @recipe.styles.count, 1
  end
  
  test "RecipeStyle should be unique" do
    @recipeStyle.save
    recipeStyle = @style.recipe_styles.create(recipe: @recipe)
    assert_not recipeStyle.valid?
    
    recipeStyle2 = @recipe.recipe_styles.create(style: @style)
    assert_not recipeStyle2.valid?
  end
  
end
