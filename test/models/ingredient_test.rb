# == Schema Information
#
# Table name: ingredients
#
#  id   :integer          not null, primary key
#  name :string
#

require 'test_helper'

class IngredientTest < ActiveSupport::TestCase
  
  def setup
    @ingredient = Ingredient.new(name: "Chicken")  
  end
  
  test "ingredient should be valid" do
    assert @ingredient.valid?
  end
  
  test "ingredient name should be present" do
    @ingredient.name = " "
    assert_not @ingredient.valid?
  end
  
  test "ingredient name should not be too long" do
    @ingredient.name = "a" * 26
    assert_not @ingredient.valid?
  end
  
  test "ingredient name should not be too short" do
    @ingredient.name = "a"
    assert_not @ingredient.valid?
  end
  
  test "ingredient name should be unique" do
    @ingredient.save
    
    ingredient = Ingredient.new(name: "Chicken")  
    assert_not ingredient.valid?
    
    ingredientCaps = Ingredient.new(name: "CHICKEN")  
    assert_not ingredientCaps.valid?
  end
  
end
