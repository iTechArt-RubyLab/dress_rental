require 'rails_helper'

RSpec.describe RentalRatingRequestWorker, type: :worker do
  it 'sends a rental rating request email if rental is archived and expired' do
    rental = create(:rental, :archived, :expired)

    expect { RentalRatingRequestWorker.perform_async(rental.id) }.to change(RentalRatingRequestWorker.jobs, :size).by(1)

    perform_enqueued_jobs do
      RentalRatingRequestWorker.new.perform(rental.id)

      expect(ActionMailer::Base.deliveries.count).to eq(1)
      expect(ActionMailer::Base.deliveries.last.to).to eq([rental.user.email])
    end
  end

  it 'does not send rental rating request email if rental is not archived or expired' do
    rental = create(:rental)

    expect { RentalRatingRequestWorker.perform_async(rental.id) }.not_to change(RentalRatingRequestWorker.jobs, :size)

    perform_enqueued_jobs do
      RentalRatingRequestWorker.new.perform(rental.id)

      expect(ActionMailer::Base.deliveries.count).to eq(0)
    end
  end

  it 'does not send rental rating request email if rental does not exist' do
    expect { RentalRatingRequestWorker.perform_async(rental.id) }.not_to change(RentalRatingRequestWorker.sidekiq_options["retry"], :size)

    perform_enqueued_jobs do
      RentalRatingRequestWorker.new.perform(0)

      expect(ActionMailer::Base.deliveries.count).to eq(0)
    end
  end
end