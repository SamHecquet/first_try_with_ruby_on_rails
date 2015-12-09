# == Schema Information
#
# Table name: styles
#
#  id   :integer          not null, primary key
#  name :string
#


require 'rails_helper'

describe Style do

  describe 'associations' do
    it { is_expected.to have_many(:recipes).class_name('Recipe') }
  end
  
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_least(2).is_at_most(25) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  end
  
end
