require 'rails_helper'

describe ChefsController do
  let!(:chef) { create(:chef) }
  let!(:count_chef) { Chef.count }
  
  describe 'GET #index' do
    it 'populates an array of chefs' do
      get :index
      expect(assigns(:chefs)).to eq([chef])
    end
    
    it 'renders the :index view' do
      get :index
      expect(response).to render_template('index')
    end
  end


  describe 'GET #new' do
    context 'when chef is not connected' do
      it 'renders the new form' do
        get :new
        
        expect(response).to be_success
        expect(response).to render_template('new')
      end
    end
    context 'when chef is connected' do
      before do
        sign_in chef
      end
      it 'redirects to recipes_path' do
        get :new
        
        expect(response).to redirect_to(recipes_path)
      end
    end
  end
  
  describe 'POST #create' do
    context 'when data are corrects' do
      it 'redirects to chef path' do
        post :create,
          chef: {
            chefname: 'Jean Michel',
            email: 'jean.michel@gmail.com',
            password: 'password'
          }
          
        # retrieve chef created
        new = Chef.find_by(email: 'jean.michel@gmail.com')
        expect(Chef.count).to eq(count_chef + 1)
          
        expect(response).to redirect_to(chef_path(new.id))
        expect(flash[:success]).to be_present
      end
    end
    context 'when data are incorrects' do
      it 'renders the new form' do
        post :create,
          chef: {
            chefname: '',
            email: 'jean.michel@gmail.com',
            password: 'password'
          }
        
        expect(Chef.count).to eq(count_chef)
        expect(response).to be_success
        expect(response).to render_template('new')
      end
    end
  end
  
  describe 'GET #edit' do
    context 'when chef connected is the same chef' do
      before do
        sign_in chef
      end
      it 'assigns the requested chef to @chef' do
        get :edit, id: chef
        expect(assigns(:chef)).to eq(chef)
        expect(response).to be_success
        expect(response).to render_template('edit')
      end
    end
    context 'when chef connected is not the same chef' do
      before do
        chef = create(:other_chef)
        sign_in chef
      end
      it 'redirects to recipes_path' do
        get :edit, id: chef
        expect(response).to redirect_to(root_path)
        expect(flash[:danger]).to be_present
      end
    end
  end
  
  describe 'PUT #update' do
    before do
      sign_in chef
    end
    context 'when data are corrects' do
      it 'redirects to recipes path' do
        put :update,
          id: chef.id,
          chef: {
            chefname: 'edited',
            email: chef.email,
            password: chef.password
          }
        chef.reload
        expect(chef.chefname).to eq('edited')
        
        expect(response).to redirect_to(recipes_path)
        expect(flash[:success]).to be_present
      end
    end
    context 'when data are incorrects' do
      it 'renders the edit form' do
        put :update,
          id: chef.id,
          chef: {
            chefname: '',
            email: chef.email,
            password: chef.password
          }
        expect(response).to be_success
        expect(response).to render_template('edit')
      end
    end
  end
  
  
  describe 'GET #show' do
    context 'when chef is connected' do
      it 'assigns the requested chef to @chef' do
        get :show, id: chef
        expect(assigns(:chef)).to eq(chef)
      end
      
      it 'renders the :show template' do
        get :show, id: chef
        expect(response).to be_success
        expect(response).to render_template('show')
      end
    end
  end
  
  
end