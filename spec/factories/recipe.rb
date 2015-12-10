FactoryGirl.define do

  factory :tomato, :class => Ingredient  do
    name 'Tomato'
  end
  
  factory :potato, :class => Ingredient  do
    name 'Potato'
  end
  
  factory :chicken, :class => Ingredient  do
    name 'chicken'
  end
  
  factory :mexican, :class => Style  do
    name 'Mexican'
  end
  
  factory :french, :class => Style  do
    name 'French'
  end
  
  factory :recipe_style_french,  :class => RecipeStyle  do
    recipe
    style factory: :french
  end
  
  factory :recipe_style_mexican,  :class => RecipeStyle  do
    recipe
    style factory: :mexican
  end
  
  factory :recipe_ingredient_potato,  :class => RecipeIngredient  do
    recipe
    ingredient factory: :potato
  end
  
  factory :recipe_ingredient_tomato,  :class => RecipeIngredient  do
    recipe
    ingredient factory: :tomato
  end
  
  factory :like do
    recipe
    chef factory: :other_chef
  end
  
  factory :recipe do
    name 'name truc'
    summary 'summary truc'
    description 'description truc assez longue ok'
    picture File.new("#{Rails.root}/spec/fixtures/files/pluto.gif")
    
    chef factory: :third_chef
    
    factory :recipe_complete do
      after(:create) do |recipe|
        create(:recipe_style_mexican, recipe: recipe )
        create(:recipe_ingredient_potato, recipe: recipe )
        create(:recipe_ingredient_tomato, recipe: recipe )
      end
      factory :recipe_complete_with_like do
         after(:create) do |recipe|
          create(:like, recipe: recipe )
        end
      end
    end
  end
  

end