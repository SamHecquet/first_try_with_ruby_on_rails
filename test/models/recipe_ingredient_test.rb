# == Schema Information
#
# Table name: recipe_ingredients
#
#  id            :integer          not null, primary key
#  ingredient_id :integer
#  recipe_id     :integer
#

require 'test_helper'

class RecipeIngredientTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.create(chefname: "bob", email: "toto@toto.com", password: "password")
    @ingredient = Ingredient.create(name: "Chicken")  
    @recipe = @chef.recipes.create(
                name: "name truc", 
                summary: "summary truc", 
                description: "description truc assez longue ok"
              )
    @recipeIngredient = @ingredient.recipe_ingredients.new(recipe: @recipe)
  end
  
  test "RecipeIngredientTest Setup should be valid" do
    assert @chef.valid?
    assert @ingredient.valid?
    assert @recipe.valid?
  end
  
  test "RecipeIngredient should be valid" do
    assert @recipeIngredient.valid?, "#{@recipeIngredient.errors.full_messages.to_s}"
    # save to compare
    assert_same @ingredient.recipes.count, 0
    assert_same @recipe.ingredients.count, 0
    @recipeIngredient.save
    assert_same @ingredient.recipes.count, 1
    assert_same @recipe.ingredients.count, 1
  end
  
  
  test "RecipeIngredient should be unique" do
    @recipeIngredient.save
    recipeIngredient = @ingredient.recipe_ingredients.create(recipe: @recipe)
    assert_not recipeIngredient.valid?
    
    recipeIngredient2 = @recipe.recipe_ingredients.create(ingredient: @ingredient)
    assert_not recipeIngredient2.valid?
  end
  
end
