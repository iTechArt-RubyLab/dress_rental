require 'sidekiq-scheduler'
class RentalExpirationNotifierWorker
  include Sidekiq::Worker

  def perform
    expiring_rentals = ExpiringRentalsSelector.call.result
    expiring_rentals.each do |rental|
      RentalMailer.rental_expiration_notification(rental).deliver_now
    end
  end
end
