# == Schema Information
#
# Table name: recipes
#
#  id          :integer          not null, primary key
#  name        :string
#  summary     :text
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  chef_id     :integer
#  picture     :string
#

require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.create(chefname: "bob", email: "toto@toto.com", password: "password")
    @recipe = @chef.recipes.build(
                name: "name truc", 
                summary: "summary truc", 
                description: "description truc assez longue ok"
              )  
  end
  
  test "recipe should be valid" do
    assert @recipe.valid?, "#{@recipe.errors.full_messages.to_s}"
  end
  
  test "recipe chef_id should be present" do
    @recipe.chef_id = nil
    assert_not @recipe.valid?
  end
  
  test "recipe name should be present" do
    @recipe.name = " "
    assert_not @recipe.valid?
    
  end
  
  test "recipe name should not be too long" do
    @recipe.name = "a" * 101
    assert_not @recipe.valid?
  end
  
  test "recipe name should not be too short" do
     @recipe.name = "aa"
    assert_not @recipe.valid?
  end
  
  test "recipe summary should be present" do
    @recipe.summary = " "
    assert_not @recipe.valid?
    
  end
  
  test "recipe summary should not be too long" do
    @recipe.summary = "a" * 151
    assert_not @recipe.valid?
  end
  
  test "recipe summary should not be too short" do
    @recipe.summary = "a" * 9
    assert_not @recipe.valid?
  end
  
  
  test "recipe description should be present" do
    @recipe.description = " "
    assert_not @recipe.valid?
  end
  
  test "recipe description should not be too long" do
    @recipe.description = "a" * 501
    assert_not @recipe.valid?
  end
  
  test "recipe description should not be too short" do
    @recipe.description = "a" * 19
    assert_not @recipe.valid?
  end
  
end
