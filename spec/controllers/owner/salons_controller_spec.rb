require 'rails_helper'
RSpec.describe Owner::SalonsController, type: :controller do
  let(:user) { create(:user) }
  let!(:salon) { create(:salon, owner: user) }

  before { sign_in user }

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template :new
      expect(response).to have_http_status(:ok)
    end

    it 'assigns a new salon to @salon' do
      get :new
      expect(assigns(:salon)).to be_a_new(Salon)
    end
  end

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template :index
      expect(response).to have_http_status(:ok)
    end

    it "assigns the user's salons to @salons" do
      get :index
      expect(assigns(:salons)).to eq([salon])
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new salon' do
        expect do
          post :create, params: { salon: attributes_for(:salon, owner_id: user.id) }
        end.to change(Salon, :count).by(1)
      end

      it 'redirects to the new salon page with a success message' do
        post :create, params: { salon: attributes_for(:salon, owner_id: user.id) }
        expect(response).to redirect_to(salon_path(assigns[:salon]))
        expect(flash[:notice]).to eq('Salon was successfully created.')
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new salon' do
        expect do
          post :create, params: { salon: attributes_for(:salon, name: '', description: '', owner_id: user.id) }
        end.to_not change(Salon, :count)
      end

      it 're-renders the new template with an error message' do
        post :create, params: { salon: attributes_for(:salon, name: '', description: '', owner_id: user.id) }
        expect(response).to render_template :new
        expect(flash[:alert]).to eq('Something went wrong. Please try again.')
      end
    end
  end

  describe 'GET #edit' do
    it 'renders the edit template' do
      get :edit, params: { id: salon.id }
      expect(response).to render_template :edit
      expect(response).to have_http_status(:ok)
    end

    it 'assigns the requested salon to @salon' do
      get :edit, params: { id: salon.id }
      expect(assigns(:salon)).to eq(salon)
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      it 'updates the specified salon' do
        put :update, params: { id: salon.id, salon: attributes_for(:salon, name: 'New Salon') }
        expect(salon.reload.name).to eq('New Salon')
        expect(response).to redirect_to(salon_path(salon))
      end

      it 'redirects to the updated salon page with a success message' do
        put :update, params: { id: salon.id, salon: attributes_for(:salon, name: 'New Salon') }
        expect(response).to redirect_to(salon_path(salon))
        expect(flash[:notice]).to eq('Salon was successfully updated.')
      end
    end

    context 'with invalid attributes' do
      it 'does not update the specified salon' do
        put :update, params: { id: salon.id, salon: attributes_for(:salon, name: '', description: '') }
        expect(salon.reload.name).to_not eq('')
        expect(response).to render_template :edit
      end

      it 're-renders the edit template with an error message' do
        put :update, params: { id: salon.id, salon: attributes_for(:salon, name: '', description: '') }
        expect(response).to render_template :edit
        expect(flash[:alert]).to eq('Something went wrong. Please try again.')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the specified salon' do
      expect do
        delete :destroy, params: { id: salon.id }
      end.to change(Salon, :count).by(-1)
    end

    it 'redirects to the salons page with a success message' do
      delete :destroy, params: { id: salon.id }
      expect(response).to redirect_to(salons_path)
      expect(flash[:notice]).to eq('Salon was successfully destroyed.')
    end
  end
end
