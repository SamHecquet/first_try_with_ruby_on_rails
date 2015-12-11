require 'spec_helper'

describe ApplicationHelper do
  let(:chef) { create(:chef) }
  describe 'gravatar_for?' do
    it 'returns a default size 80 when no size option is provided' do
      expect(helper.gravatar_for(chef)).
        to match('<img alt="Jean Michel" class="gravatar" src="https://secure.gravatar.com/avatar/50810029edcdaa02043eff094e4d37c6?s=80" />')
    end
    it 'accepts a custom size argument' do
      expect(helper.gravatar_for(chef, { size: 50 } )).
        to match('<img alt="Jean Michel" class="gravatar" src="https://secure.gravatar.com/avatar/50810029edcdaa02043eff094e4d37c6?s=50" />')
    end
    it 'ignores case' do
      chef.email = chef.email.upcase
       expect(helper.gravatar_for(chef)).
        to match('<img alt="Jean Michel" class="gravatar" src="https://secure.gravatar.com/avatar/50810029edcdaa02043eff094e4d37c6?s=80" />')
    end
  end
  describe 'sign_in' do
    it 'creates chef_id session' do
      sign_in chef
      expect(session[:chef_id]).to be_present
      expect(session[:chef_id]).to eq(chef.id)
    end
  end
end