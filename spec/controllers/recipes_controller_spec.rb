require 'rails_helper'

describe RecipesController do
  let(:chef) { create(:chef) }
  let(:admin) { create(:admin) }
  let(:recipe_complete) { create(:recipe_complete) }
  let(:chicken) { create(:chicken) }
  let(:french) { create(:french) }
  let!(:count_recipe) { Recipe.count }
  
  
  describe "GET #index" do
    it "populates an array of recipes" do
      get :index
      expect(assigns(:recipes)).to eq([recipe_complete])
    end
    
    it 'renders the :index view' do
      get :index
      expect(response).to render_template('index')
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
      it 'renders the new form' do
        get :new
        
        expect(response).to be_success
        expect(response).to render_template('new')
      end
    end
  end
  
  
  describe 'POST #create' do
    before do
      sign_in chef
    end
    context 'when data are corrects' do
      it 'redirects to recipe path' do
        post :create,
          recipe: {
            name: 'Name Recipe',
            summary: 'Summary Recipe',
            description: 'Description Recipe long enough',
            picture: Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/files/pluto.gif", 'image/gif'),
            style_ids: [french.id],
            ingredient_ids: [chicken.id]
          } 
          
        # retrieve Recipe created
        new = Recipe.find_by(name: 'Name Recipe')
        expect(Recipe.count).to eq(count_recipe + 1)
        expect(new.ingredients.count).to eq(1)
        expect(new.styles.count).to eq(1)
          
        expect(response).to redirect_to(recipe_path(new.id))
        expect(flash[:success]).to be_present
      end
    end
    context 'when data are incorrects' do
      it 'renders the new form' do
        post :create,
          recipe: {
            name: nil,
            summary: 'Summary Recipe',
            description: 'Description Recipe long enough',
            picture: Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/files/pluto.gif", 'image/gif'),
            style_ids: [],
            ingredient_ids: []
          } 
        
        expect(Recipe.count).to eq(count_recipe)
        expect(response).to be_success
        expect(response).to render_template('new')
      end
    end
  end
  
  
  describe 'GET #edit' do
    context 'when chef connected is the same chef who created the recipe' do
      it 'assigns the requested recipe to @recipe' do
        sign_in recipe_complete.chef
        
        get :edit, id: recipe_complete
        
        expect(assigns(:recipe)).to eq(recipe_complete)
        expect(response).to be_success
        expect(response).to render_template('edit')
      end
    end
    context 'when chef connected is not the same chef who created the recipe' do
      before do
        request.env['HTTP_REFERER'] = '/recipes'
        sign_in chef
      end
      it 'redirects to recipes_path' do
        get :edit, id: recipe_complete
        expect(response).to redirect_to(recipes_path)
        expect(flash[:danger]).to be_present
      end
    end
  end
  
  
  describe 'PUT #update' do
    before do
      sign_in recipe_complete.chef
    end
    context 'when data are corrects' do
      it 'redirects to recipes path' do
        put :update,
          id: recipe_complete.id,
          recipe: {
            name: 'Name Recipe edited',
            summary: 'Summary Recipe',
            description: 'Description Recipe long enough',
            picture: Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/files/pluto.gif", 'image/gif'),
            style_ids: [french.id],
            ingredient_ids: [chicken.id]
          } 
          
        recipe_complete.reload
        expect(recipe_complete.name).to eq('Name Recipe edited')
        
        expect(response).to redirect_to(recipe_path(recipe_complete.id))
        expect(flash[:success]).to be_present
      end
    end
    context 'when data are incorrects' do
      it 'renders the edit form' do
        put :update,
          id: recipe_complete.id,
          recipe: {
            name: nil,
            summary: 'Summary Recipe',
            description: 'Description Recipe long enough',
            picture: Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/files/pluto.gif", 'image/gif'),
            style_ids: [french.id],
            ingredient_ids: [chicken.id]
          } 
          
        expect(response).to be_success
        expect(response).to render_template('edit')
      end
    end
  end
  
  
  describe 'GET #show' do
    it 'assigns the requested recipe to @recipe' do
      get :show, id: recipe_complete
      expect(assigns(:recipe)).to eq(recipe_complete)
    end
    
    it 'renders the :show template' do
      get :show, id: recipe_complete
      expect(response).to be_success
      expect(response).to render_template('show')
    end
  end
  
  describe 'POST #like' do
    before do
      request.env['HTTP_REFERER'] = '/recipes'
      sign_in chef
    end
    context 'when user is connected and has not liked this recipe yet' do
      it 'creates a like' do
        post :like, id: recipe_complete
        expect(recipe_complete.likes.count).to eq(1)
      end
      it 'redirect to :back' do
        post :like, id: recipe_complete
        expect(response).to redirect_to(recipes_path)
        expect(flash[:success]).to be_present
      end
    end
    context 'when user is connected and has already liked this recipe' do
      before do
        request.env['HTTP_REFERER'] = '/recipes'
      end
      it 'doesn\'t create a like' do
        recipe = create(:recipe_complete_with_like)
         
        sign_in recipe.likes.first.chef
        post :like, id: recipe
        expect(recipe.likes.count).to eq(1)
        expect(response).to redirect_to(recipes_path)
        expect(flash[:danger]).to be_present
      end
    end
  end
  
  
  describe 'DELETE #destroy' do
    context 'when chef connected is an admin' do
      before :each do
        sign_in admin
        @recipe = recipe_complete
      end
      it "deletes the recipe" do
        expect{
          delete :destroy, id: @recipe        
        }.to change(Recipe, :count).by(-1)
      end
      it "redirects to recipes#index" do
        delete :destroy, id: @recipe
        expect(response).to redirect_to(recipes_path)
      end
    end
    context 'when chef connected is not a admin' do
      it 'redirects to recipes_path' do
        sign_in recipe_complete.chef
        delete :destroy, id: recipe_complete
        expect(response).to redirect_to(recipes_path)
      end
    end
  end

end