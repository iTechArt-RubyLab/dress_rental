class ConfirmationEmailWorker
  include Sidekiq::Worker

  def perform(rental_id)
    rental = Rental.find_by(id: rental_id)

    if rental.present?
      RentalMailer.with(rental: rental).rental_confirmation_email.deliver_now
    end
  end
end