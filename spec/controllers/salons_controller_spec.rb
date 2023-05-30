require 'rails_helper'
RSpec.describe SalonsController, type: :controller do
  let(:salon) { create(:salon) }
  let(:products) { create_list(:product, 3, salon:) }

  describe 'GET #index' do
    it 'assigns @salons' do
      get :index
      expect(assigns(:salons)).to eq [salon]
    end

    it "renders the 'index' template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    before { products }

    it 'assigns @salon' do
      get :show, params: { id: salon.id }
      expect(assigns(:salon)).to eq salon
    end

    it 'assigns @products' do
      get :show, params: { id: salon.id }
      expect(assigns(:products)).to eq products
    end

    it "renders the 'show' template" do
      get :show, params: { id: salon.id }
      expect(response).to render_template(:show)
    end
  end
end
