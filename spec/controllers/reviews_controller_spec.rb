require 'rails_helper'

describe ReviewsController do
  let(:chef) { create(:chef) }
  let(:recipe_complete) { create(:recipe_complete) }
  let!(:count_review) { Review.count }
  
  describe 'GET #new' do
    context 'when chef is not connected' do
      it 'redirects to recipes_path' do
        get :new, recipe_id: recipe_complete
        expect(response).to redirect_to(recipes_path)
      end
    end
    context 'when chef is connected' do
      before do
        sign_in chef
      end
      it 'renders the :new template' do
        get :new, recipe_id: recipe_complete
        expect(response).to render_template('new')
      end
      it 'assigns the requested recipe to @recipe' do
        get :new, recipe_id: recipe_complete
        expect(assigns(:recipe)).to eq(recipe_complete)
      end
    end
  end
  
  
  describe 'POST #create' do
    before do
      sign_in chef
    end
    context 'when data are corrects' do
      it "creates a new review" do
        expect{
          post :create, 
          recipe_id: recipe_complete,
          review: {
            body: 'Body content'
          }
        }.to change(Review,:count).by(1)
      end
      it "redirects to the recipe path" do
        post :create, 
          recipe_id: recipe_complete,
          review: {
            body: 'Body content'
          }
        expect(response).to redirect_to(recipe_path(recipe_complete))
      end
    end
    context 'when data are incorrects' do
      before do
        sign_in chef
      end
      it "does not save the new review" do
        expect{
          post :create, 
            recipe_id: recipe_complete,
            review: {
              body: nil
            }
        }.to_not change(Review,:count)
      end
      it 're-renders the new form' do
        post :create, 
          recipe_id: recipe_complete,
          review: {
            body: nil
          }
        expect(response).to be_success
        expect(response).to render_template('new')
      end
    end
  end
  
end