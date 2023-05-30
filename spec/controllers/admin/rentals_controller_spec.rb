require 'rails_helper'
RSpec.describe Admin::RentalsController, type: :controller do
  let!(:rental) { create(:rental) }
  let(:valid_attributes) { attributes_for(:rental) }
  let(:invalid_attributes) { attributes_for(:rental, start_date: nil) }
  let(:admin) { create(:user, :admin) }

  before { sign_in admin }

  describe "GET #index" do
    it "renders index template" do
      get :index
      expect(response).to render_template :index
    end

    it "assigns @rentals" do
      get :index
      expect(assigns(:rentals)).to eq([rental])
    end
  end

  describe "GET #edit" do
    it "renders edit template" do
      get :edit, params: { id: rental.id }
      expect(response).to render_template :edit
    end

    it "assigns @rental" do
      get :edit, params: { id: rental.id }
      expect(assigns(:rental)).to eq(rental)
    end
  end

  describe "PATCH #update" do
    context "with valid params" do
      it "updates the requested rental" do
        patch :update, params: { id: rental.id, rental: valid_attributes }
        rental.reload
        expect(rental.start_date.to_s).to eq(valid_attributes[:start_date].to_s)
      end

      it "redirects to the rental" do
        patch :update, params: { id: rental.id, rental: valid_attributes }
        expect(response).to redirect_to rental
      end
    end

    context "with invalid params" do
      it "does not update the rental" do
        patch :update, params: { id: rental.id, rental: invalid_attributes }
        rental.reload
        expect(rental.start_date.to_s).to_not eq(nil)
      end

      it "redirects to edit rental" do
        patch :update, params: { id: rental.id, rental: invalid_attributes }
        expect(response).to redirect_to edit_rental_path(rental)
      end

      it "has an alert message" do
        patch :update, params: { id: rental.id, rental: invalid_attributes }
        expect(flash[:alert]).to match(/can't be blank/)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested rental" do
      expect {
        delete :destroy, params: { id: rental.id }
      }.to change(Rental, :count).by(-1)
    end

    it "redirects to the rental list" do
      delete :destroy, params: { id: rental.id }
      expect(response).to redirect_to admin_rentals_path
    end

    it "has a notice message" do
      delete :destroy, params: { id: rental.id }
      expect(flash[:notice]).to eq('Rental was successfully destroyed')
    end
  end
end