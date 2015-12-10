require 'rails_helper'

describe IngredientsController do
  let!(:chef) { create(:chef) }
  let(:tomato) { create(:tomato) }
  let!(:count_ingredient) { Ingredient.count }
  
  describe 'GET #show' do
    it "assigns the requested ingredient to @ingredient" do
      get :show, id: tomato
      expect(assigns(:ingredient)).to eq(tomato)
    end
    
    it "renders the #show template" do
      get :show, id: tomato
      expect(response).to render_template('show')
    end
  end
  
  
  describe 'GET #new' do
    context 'when chef is not connected' do
      it 'redirects to recipes_path' do
        get :new
        expect(response).to redirect_to(recipes_path)
      end
    end
    context 'when chef is connected' do
      before do
        sign_in chef
      end
      it 'renders the :new template' do
        get :new
        expect(response).to render_template('new')
      end
    end
  end
  
  describe 'POST #create' do
    before do
      sign_in chef
    end
    context 'when data are corrects' do
      it 'redirects to recipes path' do
        post :create,
          ingredient: {
            name: 'carrot',
          }
          
        # retrieve Ingredient created
        new = Ingredient.find_by(name: 'carrot')
        expect(Ingredient.count).to eq(count_ingredient + 1)
          
        expect(response).to redirect_to(recipes_path)
        expect(flash[:success]).to be_present
      end
    end
    context 'when data are incorrects' do
      it 'renders the new form' do
        post :create,
          ingredient: {
            name: '',
          }
        
        expect(Ingredient.count).to eq(count_ingredient)
        expect(response).to render_template('new')
      end
    end
  end
  
  
end