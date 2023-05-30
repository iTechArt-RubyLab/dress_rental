require 'rails_helper'
RSpec.describe Owner::OwnerController, type: :controller do
  controller do
    def index
      render plain: 'Access Granted'
    end
  end

  describe 'authorize_owner!' do
    it 'redirects to root path with alert message if current user is not owner' do
      user = create(:user)
      sign_in user

      get :index

      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('Access Denied')
    end

    it 'allows access if current user is owner' do
      user = create(:user, :owner)
      sign_in user

      get :index

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq 'Access Granted'
    end
  end

  describe 'salon_owner!' do
    it 'redirects to root path with alert message if current user is not owner of specified salon' do
      user = create(:user, :owner)
      sign_in user
      salon = create(:salon)

      get :index, params: { salon_id: salon.id }

      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('Access Denied')
    end

    it 'allows access if current user is owner of specified salon' do
      user = create(:user, :owner)
      sign_in user
      salon = create(:salon, owner: user)

      get :index, params: { salon_id: salon.id }

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq 'Access Granted'
    end
  end

  describe 'salon_product!' do
    it 'redirects to root path with alert message if current user does not have access to specified product' do
      user = create(:user, :owner)
      sign_in user
      salon = create(:salon, owner: user)
      product = create(:product)

      expect do
        get :index, params: { salon_id: salon.id, product_id: product.id }
      end.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'allows access if current user has access to specified product' do
      user = create(:user, :owner)
      sign_in user
      salon = create(:salon, owner: user)
      product = create(:product, salon:)

      get :index, params: { salon_id: salon.id, product_id: product.id }

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq 'Access Granted'
    end
  end
end
