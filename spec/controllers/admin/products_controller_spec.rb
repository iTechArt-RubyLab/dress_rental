require 'rails_helper'
RSpec.describe Admin::ProductsController, type: :controller do
  let(:admin) { create(:user, :admin) }
  let(:salon) { create(:salon) }
  let(:product) { create(:product, salon:) }

  before { sign_in admin }

  describe 'GET #new' do
    before { get :new, params: { salon_id: salon.id } }

    it 'assigns a new product instance variable' do
      expect(assigns(:product)).to be_a_new(Product)
      expect(assigns(:product).salon).to eq salon
    end

    it 'renders the new template' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before { get :edit, params: { id: product.id } }

    it 'assigns the requested product instance variable' do
      expect(assigns(:product)).to eq product
    end

    it 'renders the edit template' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context 'when valid parameters are passed' do
      let(:product_params) { { product: attributes_for(:product), salon_id: salon.id } }

      it 'creates a new product instance' do
        expect { post :create, params: product_params }.to change(Product, :count).by(1)
      end

      it 'redirects to the products page with a success message' do
        post :create, params: product_params

        expect(response).to redirect_to products_path
        expect(flash[:notice]).to eq 'Product was successfully created.'
      end
    end

    context 'when invalid parameters are passed' do
      let(:product_params) { { product: attributes_for(:product, name: ''), salon_id: salon.id } }

      it 'does not create a new product instance' do
        expect { post :create, params: product_params }.to_not change(Product, :count)
      end

      it 'renders the new template with an error message' do
        post :create, params: product_params

        expect(response).to render_template :new
        expect(flash.now[:alert]).to eq 'There was an error while creating the product.'
      end
    end
  end

  describe 'PUT #update' do
    context 'when valid parameters are passed' do
      let(:product_params) { { id: product.id, product: attributes_for(:product), salon_id: salon.id } }

      it 'updates the product instance' do
        put :update, params: product_params

        product.reload

        expect(product.name).to eq(attributes_for(:product)[:name])
      end

      it 'redirects to the products page with a success message' do
        put :update, params: product_params

        expect(response).to redirect_to products_path
        expect(flash[:notice]).to eq 'Product was successfully updated.'
      end
    end

    context 'when invalid parameters are passed' do
      let(:product_params) { { id: product.id, product: attributes_for(:product, name: ''), salon_id: salon.id } }

      it 'does not update the product instance' do
        put :update, params: product_params

        product.reload

        expect(product.name).to_not eq(attributes_for(:product)[:name])
      end

      it 'renders the edit template with an error message' do
        put :update, params: product_params

        expect(response).to render_template :edit
        expect(flash.now[:alert]).to eq 'There was an error while updating the product.'
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested product instance' do
      product

      expect { delete :destroy, params: { id: product.id } }.to change(Product, :count).by(-1)
    end

    it 'redirects to the products page with a success message' do
      product

      delete :destroy, params: { id: product.id }

      expect(response).to redirect_to products_path
      expect(flash[:notice]).to eq 'Product was successfully destroyed.'
    end
  end
end
