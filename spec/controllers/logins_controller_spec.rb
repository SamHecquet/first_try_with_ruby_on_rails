require 'rails_helper'

describe LoginsController do
  let(:user) { create(:chef) }
  
  describe 'GET #new' do
    context 'when user is not connected' do
      it 'renders the login form' do
        get :new
        
        expect(response).to be_success
        expect(response).to render_template('new')
      end
    end
    context 'when user is connected' do
      before do
        sign_in user
      end
      it 'redirects to recipes_path' do
        get :new
        
        expect(response).to redirect_to(recipes_path)
      end
    end
  end
  
  
  describe 'POST #create' do
    context 'when identifiants are corrects' do
      it 'redirects to recipes path' do
        post :create,
          email: user.email,
          password: user.password
          
        expect(response).to redirect_to(recipes_path)
        expect(flash[:success]).to be_present
      end
    end
    context 'when identifiants are incorrects' do
      it 'renders the login form' do
        post :create,
          email: 'email',
          password: 'password'
          
        expect(response).to be_success
        expect(response).to render_template('new')
        expect(flash[:danger]).to be_present
      end
    end
  end
  
  describe 'GET #destroy' do
    before do
      request.env['HTTP_REFERER'] = '/recipes'
      sign_in user
    end
    context 'when user is connected' do
      it 'redirects to recipes_path' do
        get :destroy
        
        expect(response).to redirect_to(recipes_path)
        expect(flash[:success]).to be_present
      end
    end
  end
  
end