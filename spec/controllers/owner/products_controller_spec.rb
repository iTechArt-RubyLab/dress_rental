require 'rails_helper'
RSpec.describe Owner::ProductsController, type: :controller do
  let(:user) { create(:user) }
  let(:salon) { create(:salon, owner: user) }
  let!(:product) { create(:product, salon:) }

  context 'when not logged in' do
    describe 'GET #new' do
      it 'redirects to login page' do
        get :new, params: { salon_id: salon.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'POST #create' do
      it 'redirects to login page' do
        post :create, params: { salon_id: salon.id, product: attributes_for(:product) }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET #edit' do
      it 'redirects to login page' do
        get :edit, params: { id: product.id, salon_id: salon.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'PUT #update' do
      it 'redirects to login page' do
        put :update,
            params: { id: product.id, salon_id: salon.id, product: attributes_for(:product, name: 'New Product') }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'DELETE #destroy' do
      it 'redirects to login page' do
        delete :destroy, params: { id: product.id, salon_id: salon.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context 'when logged in as non-owner user' do
    before { sign_in create(:user) }

    describe 'GET #new' do
      it 'redirects to salon page' do
        get :new, params: { salon_id: salon.id }
        expect(response).to redirect_to(salon_path(salon))
      end
    end

    describe 'POST #create' do
      it 'redirects to salon page' do
        post :create, params: { salon_id: salon.id, product: attributes_for(:product) }
        expect(response).to redirect_to(salon_path(salon))
      end
    end

    describe 'GET #edit' do
      it 'redirects to salon page' do
        get :edit, params: { id: product.id, salon_id: salon.id }
        expect(response).to redirect_to(salon_path(salon))
      end
    end

    describe 'PUT #update' do
      it 'redirects to salon page' do
        put :update,
            params: { id: product.id, salon_id: salon.id, product: attributes_for(:product, name: 'New Product') }
        expect(response).to redirect_to(salon_path(salon))
      end
    end

    describe 'DELETE #destroy' do
      it 'redirects to salon page' do
        delete :destroy, params: { id: product.id, salon_id: salon.id }
        expect(response).to redirect_to(salon_path(salon))
      end
    end
  end

  context 'when logged in as owner' do
    before { sign_in user }

    describe 'GET #new' do
      it 'renders the new template' do
        get :new, params: { salon_id: salon.id }
        expect(response).to render_template :new
      end
    end

    describe 'POST #create' do
      context 'with valid attributes' do
        it 'creates a new product' do
          expect do
            post :create, params: { salon_id: salon.id, product: attributes_for(:product) }
          end.to change(Product, :count).by(1)
        end

        it 'redirects to products page with a success message' do
          post :create, params: { salon_id: salon.id, product: attributes_for(:product) }
          expect(response).to redirect_to(products_path)
          expect(flash[:notice]).to eq('Product was successfully created.')
        end
      end

      context 'with invalid attributes' do
        it 'does not create a new product' do
          expect do
            post :create, params: { salon_id: salon.id, product: attributes_for(:product, name: '') }
          end.to_not change(Product, :count)
        end

        it 're-renders the new template with an error message' do
          post :create, params: { salon_id: salon.id, product: attributes_for(:product, name: '') }
          expect(response).to render_template :new
          expect(flash[:alert]).to eq('There was an error while creating the product.')
        end
      end
    end

    describe 'GET #edit' do
      it 'renders the edit template' do
        get :edit, params: { id: product.id, salon_id: salon.id }
        expect(response).to render_template :edit
      end
    end

    describe 'PUT #update' do
      context 'with valid attributes' do
        it 'updates the specified product' do
          put :update,
              params: { id: product.id, salon_id: salon.id, product: attributes_for(:product, name: 'New Product') }
          expect(product.reload.name).to eq('New Product')
        end

        it 'redirects to products page with a success message' do
          put :update,
              params: { id: product.id, salon_id: salon.id, product: attributes_for(:product, name: 'New Product') }
          expect(response).to redirect_to(products_path)
          expect(flash[:notice]).to eq('Product was successfully updated.')
        end
      end

      context 'with invalid attributes' do
        it 'does not update the specified product' do
          put :update, params: { id: product.id, salon_id: salon.id, product: attributes_for(:product, name: '') }
          expect(product.reload.name).to_not eq('')
        end

        it 'redirects to edit page with an error message' do
          put :update, params: { id: product.id, salon_id: salon.id, product: attributes_for(:product, name: '') }
          expect(response).to redirect_to(edit_owner_product_path(product))
          expect(flash[:alert]).to eq('There was an error while updating the product.')
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'deletes the specified product' do
        expect do
          delete :destroy, params: { id: product.id, salon_id: salon.id }
        end.to change(Product, :count).by(-1)
      end

      it 'redirects to products page with a success message' do
        delete :destroy, params: { id: product.id, salon_id: salon.id }
        expect(response).to redirect_to(products_path)
        expect(flash[:notice]).to eq('Product was successfully destroyed.')
      end
    end
  end
end
