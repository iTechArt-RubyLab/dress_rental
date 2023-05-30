require 'rails_helper'
RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:valid_user_params) { attributes_for(:user, first_name: 'new name') }
  let(:invalid_user_params) { attributes_for(:user, email: '') }

  before { sign_in user }

  describe 'GET #show' do
    it "renders the 'show' template" do
      get :show, params: { id: user.id }
      expect(response).to render_template :show
    end
  end

  describe 'GET #edit' do
    it "renders the 'edit' template" do
      get :edit, params: { id: user.id }
      expect(response).to render_template 'shared/users/edit'
    end
  end

  describe 'PATCH #update' do
    it "updates the user and redirects to 'show' with a success notice" do
      patch :update, params: { id: user.id, user: valid_user_params }
      user.reload
      expect(user.first_name).to eq valid_user_params[:first_name]
      expect(response).to redirect_to user_path(user)
      expect(flash[:notice]).to eq 'Profile has been updated.'
    end

    it "renders 'edit' with an error alert if the user update fails" do
      patch :update, params: { id: user.id, user: invalid_user_params }
      expect(response).to render_template 'shared/users/edit'
      expect(flash[:alert]).to eq 'There was a problem updating the profile.'
    end
  end

  describe 'POST #request_owner_access' do
    it "queues a job to send an email and redirects to 'show' with a success notice" do
      expect do
        post :request_owner_access
      end.to change(RequestOwnerAccessWorker.jobs, :size).by(1)

      expect(response).to redirect_to user_path(user)
      expect(flash[:notice]).to eq 'Request letter was send to admin. Thank you for trusting us!'
    end
  end
end
