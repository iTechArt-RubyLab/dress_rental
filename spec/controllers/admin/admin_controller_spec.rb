require 'rails_helper'
RSpec.describe Admin::AdminController, type: :controller do
  controller do
    def index
      render plain: 'Access Granted'
    end
  end

  describe 'authorize_admin!' do
    it 'redirects to root path with alert message if current user is not admin' do
      user = create(:user)
      sign_in user

      get :index

      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('Access Denied')
    end

    it 'allows access if current user is admin' do
      user = create(:user, :admin)
      sign_in user

      get :index

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq 'Access Granted'
    end
  end
end
