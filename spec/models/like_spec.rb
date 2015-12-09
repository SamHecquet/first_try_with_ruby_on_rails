# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  like       :boolean
#  chef_id    :integer
#  recipe_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

describe Like do

  describe 'associations' do
    it { is_expected.to belong_to(:chef).class_name('Chef') }
    it { is_expected.to belong_to(:recipe).class_name('Recipe') }
  end
  
  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:chef_id).scoped_to(:recipe_id) }
  end
  
  describe "Respond to" do
  end
  
end
