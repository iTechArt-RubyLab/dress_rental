require 'rails_helper'
RSpec.describe ProductsController, type: :controller do
  describe 'GET #index' do
    let!(:products) { create_list(:product, 3) }

    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns @products' do
      get :index
      expect(assigns(:products)).to eq products
    end
  end

  describe 'GET #show' do
    let!(:product) { create(:product) }

    it 'returns a success response' do
      get :show, params: { id: product.id }
      expect(response).to be_successful
    end

    it 'assigns @product' do
      get :show, params: { id: product.id }
      expect(assigns(:product)).to eq product
    end
  end

  describe 'GET #search' do
    let!(:product) { create(:product, name: 'Shampoo') }

    context 'with query param' do
      it 'returns a success response' do
        get :search, params: { product_search: { query: 'Shampoo' } }
        expect(response).to be_successful
      end

      it 'assigns @products' do
        get :search, params: { product_search: { query: 'Shampoo' } }
        expect(assigns(:products)).to eq [product]
      end
    end

    context 'without query param' do
      it 'returns a success response' do
        get :search
        expect(response).to be_successful
      end

      it 'assigns @query to nil' do
        get :search
        expect(assigns(:query)).to be_nil
      end

      it 'assigns @products to empty array' do
        get :search
        expect(assigns(:products)).to eq []
      end
    end
  end
end
