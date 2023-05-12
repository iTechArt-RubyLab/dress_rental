class RentalExpirationWorker
  include Sidekiq::Worker

  def perform(rental_id)
    rental = Rental.find(rental_id)

    if rental.present?
      RentalMailer.rental_expiration_notification(rental).deliver_now
    end
  end
end