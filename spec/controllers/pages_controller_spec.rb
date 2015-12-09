require 'rails_helper'

describe PagesController do
  describe 'GET #home' do
    let(:user) { create(:chef) }
    
    context 'when user is not connected' do
      it 'renders the home template' do
        get :home
        
        expect(response).to be_success
        expect(response).to render_template('home')
      end
    end
    context 'when user is connected' do
      before do
        sign_in user
      end
      it 'redirects to recipes_path' do
        get :home
        
        expect(response).to redirect_to(recipes_path)
      end
    end
  end
  
end