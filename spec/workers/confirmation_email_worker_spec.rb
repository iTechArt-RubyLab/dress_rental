require 'rails_helper'

RSpec.describe ConfirmationEmailWorker, type: :worker do
  describe '#perform' do
    context 'when rental exists' do
      let(:rental) { create(:rental) }
      let(:mail) { double('RentalMailer', deliver_now: true) }

      it 'sends rental confirmation email' do
        expect(Rental).to receive(:find_by).with(id: rental.id).and_return(rental)
        expect(RentalMailer).to receive(:with).with(rental:).and_return(mail)
        expect(mail).to receive(:rental_confirmation_email).and_return(mail)
        expect(mail).to receive(:deliver_now)

        ConfirmationEmailWorker.new.perform(rental.id)
      end
    end

    context 'when rental does not exist' do
      it 'does not send email' do
        expect(Rental).to receive(:find_by).with(id: nil).and_return(nil)
        expect(RentalMailer).not_to receive(:with)

        ConfirmationEmailWorker.new.perform(nil)
      end
    end
  end
end
