# == Schema Information
#
# Table name: chefs
#
#  id              :integer          not null, primary key
#  chefname        :string
#  email           :string
#  created_at      :datetime
#  updated_at      :datetime
#  password_digest :string
#  admin           :boolean          default(FALSE)
#

require 'rails_helper'

describe Chef do

  describe 'associations' do
    it { is_expected.to have_many(:recipes).class_name('Recipe') }
    it { is_expected.to have_many(:likes).class_name('Like') }
    it { is_expected.to have_many(:reviews).class_name('Review') }
  end
  
  describe 'validations' do
    it { is_expected.to validate_presence_of(:chefname) }
    it { is_expected.to validate_length_of(:chefname).is_at_least(3).is_at_most(40) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_length_of(:email).is_at_least(3).is_at_most(105) }
    it { is_expected.to have_secure_password }
    
    describe :email do
      it 'accepts example@example.com' do
        chef = build(:chef, email: 'example@example.com')
        expect(chef).to be_valid
      end
      it 'rejects %w[toto@titi,com' do
        chef = build(:chef, email: '%w[toto@titi,com')
        expect(chef).to be_invalid
      end
    end
   
  end
  
  describe "Respond to" do
    it { is_expected.to respond_to(:is_admin?) }
  end
  
end
