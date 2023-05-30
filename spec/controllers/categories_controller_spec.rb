require 'rails_helper'
RSpec.describe CategoriesController, type: :controller do
  describe 'GET #index' do
    let!(:categories) { create_list(:category, 3) }

    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns @categories' do
      get :index
      expect(assigns(:categories)).to eq categories
    end
  end

  describe 'GET #show' do
    let!(:category) { create(:category) }

    it 'returns a success response' do
      get :show, params: { id: category.id }
      expect(response).to be_successful
    end

    it 'assigns @category' do
      get :show, params: { id: category.id }
      expect(assigns(:category)).to eq category
    end
  end
end
