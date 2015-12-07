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

  describe 'modules' do
  end
  
  describe 'associations' do
    # it { is_expected.to have_many(:recipes) }
  end
  
  describe 'validations' do
    it { is_expected.to validate_presence_of(:chefname) }
    it { is_expected.to validate_presence_of(:email) }
  end
end
