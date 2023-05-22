class RentalRatingRequestWorker
  include Sidekiq::Worker

  def perform(rental_id)
    rental = Rental.find_by(id: rental_id)

    if rental.present? && rental.archived? && rental.expired?
      RentalMailer.rental_rating_request_notification(rental).deliver_now
    end
  end
end