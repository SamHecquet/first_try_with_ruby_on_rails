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

require 'rails_helper'

describe Recipe do

  describe 'associations' do
    it { is_expected.to belong_to(:chef).class_name('Chef') }
    it { is_expected.to have_many(:likes).class_name('Like').dependent(:destroy) }
    it { is_expected.to have_many(:reviews).class_name('Review').dependent(:destroy) }
    it { is_expected.to have_many(:styles).class_name('Style') }
    it { is_expected.to have_many(:ingredients).class_name('Ingredient') }
  end 
  
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_least(5).is_at_most(100) }
    it { is_expected.to validate_presence_of(:summary) }
    it { is_expected.to validate_length_of(:summary).is_at_least(10).is_at_most(150) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_length_of(:description).is_at_least(20).is_at_most(500) }
    it { is_expected.to validate_presence_of(:picture) }
    
    describe :picture do
      it 'accepts a gif' do
        recipe = build(:recipe, picture: File.new("#{Rails.root}/spec/fixtures/files/pluto.gif"))
        expect(recipe).to be_valid
      end
      
      it 'rejects a .html' do
        recipe = build(:recipe, picture: File.new("#{Rails.root}/spec/fixtures/files/pluto.html"))
        expect(recipe).to be_invalid
      end
    end
  end
  
  describe "Respond to" do
    it { is_expected.to respond_to(:thumbs_up_total) }
    it { is_expected.to respond_to(:thumbs_down_total) }
  end
  
end
