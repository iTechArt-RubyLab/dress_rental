require 'rails_helper'
RSpec.describe Admin::UsersController, type: :controller do
  let(:admin) { create(:user, :admin) }
  let(:user) { create(:user) }

  before do
    allow(controller).to receive(:current_user).and_return(admin)
  end

  describe 'GET #index' do
    it 'renders index template' do
      get :index
      expect(response).to render_template :index
    end

    it 'assigns all users to @users' do
      get :index
      expect(assigns(:users)).to include(user)
    end
  end

  describe 'GET #show' do
    it 'renders show template' do
      get :show, params: { id: user.id }
      expect(response).to render_template :show
    end

    it 'assigns the requested user to @user' do
      get :show, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'GET #edit' do
    it 'renders edit template' do
      get :edit, params: { id: user.id }
      expect(response).to render_template :edit
    end

    it 'assigns the requested user to @user' do
      get :edit, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      let(:new_attributes) { attributes_for(:user, first_name: 'New First Name') }

      it 'updates the user' do
        patch :update, params: { id: user.id, user: new_attributes }
        user.reload
        expect(user.first_name).to eq('New First Name')
      end

      it 'redirects to the admin users page' do
        patch :update, params: { id: user.id, user: new_attributes }
        expect(response).to redirect_to admin_users_path
      end

      it 'has a notice message' do
        patch :update, params: { id: user.id, user: new_attributes }
        expect(flash[:notice]).to eq('Profile successfully updated.')
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) { attributes_for(:user, first_name: nil) }

      it 'does not update the user' do
        patch :update, params: { id: user.id, user: invalid_attributes }
        user.reload
        expect(user.first_name).to_not eq(nil)
      end

      it 'redirects to the user edit page' do
        patch :update, params: { id: user.id, user: invalid_attributes }
        expect(response).to redirect_to edit_user_path(user)
      end

      it 'has an alert message' do
        patch :update, params: { id: user.id, user: invalid_attributes }
        expect(flash[:alert]).to eq('Something went wrong.')
      end
    end
  end

  describe 'PATCH #confirm_owner' do
    it "updates the user's role to owner" do
      patch :confirm_owner, params: { id: user.id }
      user.reload
      expect(user.owner?).to eq(true)
    end

    it 'redirects to the admin users page' do
      patch :confirm_owner, params: { id: user.id }
      expect(response).to redirect_to admin_users_path
    end

    it 'has a notice message' do
      patch :confirm_owner, params: { id: user.id }
      expect(flash[:notice]).to eq('User successfully updated.')
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the user' do
      delete :destroy, params: { id: user.id }
      expect(User.all).to_not include(user)
    end

    it 'redirects to the admin users page' do
      delete :destroy, params: { id: user.id }
      expect(response).to redirect_to admin_users_path
    end

    it 'has a notice message' do
      delete :destroy, params: { id: user.id }
      expect(flash[:notice]).to eq('User was successfully destroyed.')
    end
  end
end
