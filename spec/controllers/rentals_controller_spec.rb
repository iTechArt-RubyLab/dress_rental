require 'rails_helper'
RSpec.describe RentalsController, type: :controller do
  let(:user) { create(:user) }
  let(:rental) { create(:rental, user:) }
  let(:salon) { create(:salon) }
  let(:product) { create(:product, salon:) }

  describe 'GET #new' do
    before { sign_in(user) }

    it 'assigns a new rental as @rental' do
      get :new
      expect(assigns(:rental)).to be_a_new(Rental)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested rental as @rental' do
      get :show, params: { id: rental.to_param }
      expect(assigns(:rental)).to eq(rental)
    end
  end

  describe 'POST #create' do
    before { sign_in(user) }

    context 'with valid params' do
      it 'creates a new Rental' do
        expect do
          post :create, params: { rental: attributes_for(:rental, product_id: product.id) }
        end.to change(Rental, :count).by(1)
      end

      it 'assigns a newly created rental as @rental' do
        post :create, params: { rental: attributes_for(:rental, product_id: product.id) }
        expect(assigns(:rental)).to be_a(Rental)
        expect(assigns(:rental)).to be_persisted
      end

      it 'sends confirmation email' do
        post :create, params: { rental: attributes_for(:rental, product_id: product.id) }
        expect(ConfirmationEmailWorker).to have_enqueued_sidekiq_job(assigns(:rental).id)
      end

      it 'redirects to the created rental' do
        post :create, params: { rental: attributes_for(:rental, product_id: product.id) }
        expect(response).to redirect_to(Rental.last)
      end

      it 'sets a flash notice' do
        post :create, params: { rental: attributes_for(:rental, product_id: product.id) }
        expect(flash[:notice]).to eq 'Request for confirming the rental has been send to the owner.'
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved rental as @rental' do
        post :create, params: { rental: attributes_for(:rental, start_date: '', product_id: product.id) }
        expect(assigns(:rental)).to be_a_new(Rental)
      end

      it 'redirects to the new rental with an error message' do
        post :create, params: { rental: attributes_for(:rental, start_date: '', product_id: product.id) }
        expect(response).to redirect_to(new_rental_path)
        expect(flash[:alert]).to eq "Start date can't be blank"
      end
    end
  end

  describe 'GET #confirm' do
    context 'with valid rental confirmation' do
      let(:rental) { create(:rental, :unconfirmed) }

      it 'confirms the rental and redirects to the rental page' do
        get :confirm, params: { confirmation_token: rental.confirmation_token, rental_id: rental.id }
        expect(Rental.find(rental.id).confirmed?).to be true
        expect(response).to redirect_to rental_path(rental)
      end

      it 'sends confirmation email' do
        get :confirm, params: { confirmation_token: rental.confirmation_token, rental_id: rental.id }
        expect(UserRentalConfirmationEmailWorker).to have_enqueued_sidekiq_job(rental.id)
      end
    end

    context 'with invalid rental confirmation' do
      it 'redirects to the root url with an error message' do
        get :confirm, params: { confirmation_token: 'invalid_token', rental_id: rental.id }
        expect(response).to redirect_to(root_url)
        expect(flash[:alert]).to eq 'Invalid confirmation token.'
      end
    end
  end

  describe 'GET #rate_salon' do
    before { sign_in(user) }

    it 'renders the rate_salon template' do
      get :rate_salon, params: { rental_id: rental.id }
      expect(response).to render_template :rate_salon
    end
  end

  describe 'GET #rate_user' do
    before { sign_in(user) }

    it 'renders the rate_user template' do
      get :rate_user, params: { rental_id: rental.id }
      expect(response).to render_template :rate_user
    end
  end

  describe 'PUT #update_salon_rating' do
    before { sign_in(user) }

    it 'updates the salon rating and redirects to the salon page' do
      put :update_salon_rating, params: {
        rental_id: rental.id,
        rental: { salon_rating: 3 }
      }
      expect(assigns(:rental).salon_rating).to eq(3)
      expect(response).to redirect_to rental.product.salon
    end
  end

  describe 'PUT #update_user_rating' do
    before { sign_in(user) }

    it 'updates the user rating and redirects to the salon page' do
      put :update_user_rating, params: {
        rental_id: rental.id,
        rental: { user_rating: 3 }
      }
      expect(assigns(:rental).user_rating).to eq(3)
      expect(response).to redirect_to rental.product.salon
    end
  end

  describe 'GET #edit' do
    before { sign_in(user) }

    it 'renders the edit partial' do
      get :edit, params: { id: rental.id }
      expect(response).to render_template :_edit
    end
  end

  describe 'PUT #update' do
    before { sign_in(user) }

    context 'with valid params' do
      let(:new_attributes) { { start_date: '2022-01-01' } }

      it 'updates the requested rental' do
        put :update, params: { id: rental.id, rental: new_attributes }

        expect(rental.reload.start_date).to eq('2022-01-01')
      end

      it 'redirects to the rental' do
        put :update, params: { id: rental.id, rental: new_attributes }

        expect(response).to redirect_to(rental)
      end

      it 'sets a flash notice' do
        put :update, params: { id: rental.id, rental: new_attributes }
        expect(flash[:notice]).to eq 'Rental was successfully updated.'
      end
    end

    context 'with invalid params' do
      it 'does not update the rental' do
        put :update, params: { id: rental.id, rental: attributes_for(:rental, start_date: '') }

        expect(rental.reload.start_date).not_to eq('')
      end

      it 'redirects to the edit rental page' do
        put :update, params: { id: rental.id, rental: attributes_for(:rental, start_date: '') }

        expect(response).to redirect_to(edit_rental_path)
      end

      it 'sets a flash alert' do
        put :update, params: { id: rental.id, rental: attributes_for(:rental, start_date: '') }
        expect(flash[:alert]).to include('Start date can\'t be blank')
      end
    end
  end

  describe 'GET #export_csv' do
    before { sign_in(user) }

    it 'should export all rentals to a CSV file' do
      rental
      get :export_csv

      expect(response.headers['Content-Type']).to eq('text/csv')
      expect(response.status).to eq(200)
    end
  end

  describe 'DELETE #destroy' do
    before { sign_in(user) }

    it 'destroys the requested rental' do
      rental = create(:rental)
      expect do
        delete :destroy, params: { id: rental.to_param }
      end.to change(Rental, :count).by(-1)
    end

    it 'redirects to the user page' do
      delete :destroy, params: { id: rental.to_param }
      expect(response).to redirect_to(user_path(user))
    end

    it 'sets a flash notice' do
      delete :destroy, params: { id: rental.to_param }
      expect(flash[:notice]).to eq 'Rental was successfully destroyed.'
    end
  end

  private

  def sign_in(user)
    allow(controller).to receive(:authenticate_user!).and_return(true)
    allow(controller).to receive(:current_user).and_return(user)
  end
end
