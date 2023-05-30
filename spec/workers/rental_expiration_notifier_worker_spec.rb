require 'rails_helper'

RSpec.describe RentalExpirationNotifierWorker, type: :worker do
  it 'sends expiration notification email to expiring rentals' do
    rental1 = create(:rental, :confirmed)
    rental2 = create(:rental, :confirmed)
    create(:rental)

    expect(ExpiringRentalsSelector).to receive(:call).and_return(Response.new([rental1, rental2]))

    expect { RentalExpirationNotifierWorker.perform_async }.to change(RentalExpirationNotifierWorker.jobs, :size).by(1)

    perform_enqueued_jobs do
      RentalExpirationNotifierWorker.new.perform

      expect(ActionMailer::Base.deliveries.count).to eq(2)
      expect(ActionMailer::Base.deliveries.last.to).to eq([rental2.user.email])
    end
  end

  it 'does not send expiration notification email if there are no expiring rentals' do
    expect(ExpiringRentalsSelector).to receive(:call).and_return({ rentals: [] })

    expect { RentalExpirationNotifierWorker.perform_async }.not_to change(RentalExpirationNotifierWorker.jobs, :size)

    perform_enqueued_jobs do
      RentalExpirationNotifierWorker.new.perform

      expect(ActionMailer::Base.deliveries.count).to eq(0)
    end
  end
end
