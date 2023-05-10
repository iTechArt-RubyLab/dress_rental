class RentalExpirationWorker
  include Sidekiq::Worker

  def perform(rental_id)
    rental = Rental.find(rental_id)

    if rental.end_date < 5.days.from_now
      RentalMailer.rental_expiration_notification(rental).deliver_now
    end
  end
end