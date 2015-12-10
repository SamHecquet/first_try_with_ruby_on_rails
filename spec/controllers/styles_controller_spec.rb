require 'rails_helper'

describe StylesController do
  let!(:chef) { create(:chef) }
  let(:french) { create(:french) }
  let!(:count_style) { Style.count }
  
  describe 'GET #show' do
    it "assigns the requested style to @style" do
      get :show, id: french
      expect(assigns(:style)).to eq(french)
    end
    
    it "renders the #show template" do
      get :show, id: french
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
          style: {
            name: 'carrot',
          }
          
        # retrieve Style created
        new = Style.find_by(name: 'carrot')
        expect(Style.count).to eq(count_style + 1)
          
        expect(response).to redirect_to(recipes_path)
        expect(flash[:success]).to be_present
      end
    end
    context 'when data are incorrects' do
      it 'renders the new form' do
        post :create,
          style: {
            name: nil,
          }
        
        expect(Style.count).to eq(count_style)
        expect(response).to render_template('new')
      end
    end
  end
  
  
end