require 'rails_helper'
RSpec.describe Admin::SalonsController, type: :controller do
  let!(:owner) { create(:user) }
  let(:valid_attributes) { attributes_for(:salon, owner_id: owner.id) }
  let(:invalid_attributes) { attributes_for(:salon, name: nil) }
  let(:salon) { create(:salon, owner:) }

  describe 'GET #new' do
    it 'renders new template' do
      get :new
      expect(response).to render_template :new
    end

    it 'assigns a new salon' do
      get :new
      expect(assigns(:salon)).to be_a_new(Salon)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new salon' do
        expect do
          post :create, params: { salon: { name: 'Salon name', address: 'Salon address' } }
        end.to change(Salon, :count).by(1)
      end

      it 'redirects to the salon show page' do
        post :create, params: { salon: { name: 'Salon name', address: 'Salon address' } }
        expect(response).to redirect_to(salon_path(assigns[:salon]))
      end

      it 'displays a success message' do
        post :create, params: { salon: { name: 'Salon name', address: 'Salon address' } }
        expect(flash[:notice]).to eq('Salon was successfully created.')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new salon' do
        expect do
          post :create, params: { salon: { name: '', address: '' } }
        end.to_not change(Salon, :count)
      end

      it 'renders the new template' do
        post :create, params: { salon: { name: '', address: '' } }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    it 'renders edit template' do
      get :edit, params: { id: salon.id }
      expect(response).to render_template :edit
    end

    it 'assigns @salon' do
      get :edit, params: { id: salon.id }
      expect(assigns(:salon)).to eq(salon)
    end
  end

  describe 'PATCH #update' do
    let(:salon) { create(:salon) }

    context 'with valid parameters' do
      it 'updates the requested salon' do
        patch :update, params: { id: salon.id, salon: { name: 'New salon name' } }
        salon.reload
        expect(salon.name).to eq('New salon name')
      end

      it 'redirects to the salon show page' do
        patch :update, params: { id: salon.id, salon: { name: 'New salon name' } }
        expect(response).to redirect_to(salon_path(salon))
      end

      it 'displays a success message' do
        patch :update, params: { id: salon.id, salon: { name: 'New salon name' } }
        expect(flash[:notice]).to eq('Salon was successfully updated.')
      end
    end

    context 'with invalid parameters' do
      it 'does not update the requested salon' do
        patch :update, params: { id: salon.id, salon: { name: '' } }
        salon.reload
        expect(salon.name).to_not eq('')
      end

      it 'renders the edit template' do
        patch :update, params: { id: salon.id, salon: { name: '' } }
        expect(response).to render_template(:edit)
      end

      it 'displays an error message' do
        patch :update, params: { id: salon.id, salon: { name: '' } }
        expect(flash[:alert]).to eq('Something went wrong. Please try again.')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested salon' do
      expect do
        delete :destroy, params: { id: salon.id }
      end.to change(Salon, :count).by(-1)
    end

    it 'redirects to the salon list' do
      delete :destroy, params: { id: salon.id }
      expect(response).to redirect_to salons_path
    end

    it 'has a notice message' do
      delete :destroy, params: { id: salon.id }
      expect(flash[:notice]).to eq('Salon was successfully destroyed.')
    end
  end
end
