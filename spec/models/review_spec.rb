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

require 'rails_helper'

describe Review do

  describe 'associations' do
    it { is_expected.to belong_to(:chef).class_name('Chef') }
    it { is_expected.to belong_to(:recipe).class_name('Recipe') }
  end
  
  describe 'validations' do
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_length_of(:body).is_at_least(5).is_at_most(500) }
  end
  
  describe "Respond to" do
  end
  
end
