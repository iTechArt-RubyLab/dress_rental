require 'rails_helper'

RSpec.describe ExpiredRentalsArchiverWorker, type: :worker do
  describe '#perform' do
    it 'archives expired rentals' do
      rental = create(:rental, end_date: 1.day.ago, status: :confirmed)

      expect do
        ExpiredRentalsArchiverWorker.new.perform
        rental.reload
      end.to change { rental.status }.from('confirmed').to('archived')
    end

    it 'creates rental rating request worker job' do
      rental = create(:rental, end_date: 1.day.ago, status: :confirmed)

      expect do
        ExpiredRentalsArchiverWorker.new.perform
      end.to have_enqueued_job(RentalRatingRequestWorker).with(rental.id)
    end
  end
end
