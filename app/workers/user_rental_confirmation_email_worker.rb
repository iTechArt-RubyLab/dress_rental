class UserRentalConfirmationEmailWorker
  include Sidekiq::Worker

  def perform(rental_id)
    rental = Rental.find_by(id: rental_id)

    return if rental.blank?

    RentalMailer.rental_confirmation_notification(rental).deliver_now
  end
end
