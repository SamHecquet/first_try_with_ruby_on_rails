FactoryGirl.define do
  factory :recipe do
    chef
    name 'name truc'
    summary 'summary truc'
    description 'description truc assez longue ok'
    picture File.new("#{Rails.root}/spec/fixtures/files/pluto.gif")
  end
end