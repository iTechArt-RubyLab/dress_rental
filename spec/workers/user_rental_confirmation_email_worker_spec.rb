require 'rails_helper'

RSpec.describe UserRentalConfirmationEmailWorker, type: :worker do
  describe "#perform" do
    let(:rental) { create(:rental) }
    let(:mail) { double("RentalMailer", deliver_now: true) }

    context "when rental exists" do
      it "sends rental confirmation email" do
        expect(Rental).to receive(:find_by).with(id: rental.id).and_return(rental)
        expect(RentalMailer).to receive(:rental_confirmation_notification).with(rental).and_return(mail)

        UserRentalConfirmationEmailWorker.new.perform(rental.id)
      end

      it "sends email with deliver_now method" do
        allow(Rental).to receive(:find_by).and_return(rental)
        expect(RentalMailer).to receive(:rental_confirmation_notification).with(rental).and_return(mail)
        expect(mail).to receive(:deliver_now)

        UserRentalConfirmationEmailWorker.new.perform(rental.id)
      end
    end

    context "when rental does not exist" do
      it "does not send email" do
        expect(Rental).to receive(:find_by).with(id: rental.id).and_return(nil)
        expect(RentalMailer).not_to receive(:rental_confirmation_notification)

        UserRentalConfirmationEmailWorker.new.perform(rental.id)
      end
    end
  end
end