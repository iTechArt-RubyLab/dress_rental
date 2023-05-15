require 'sidekiq-scheduler'
class RentalExpirationNotifierWorker
  include Sidekiq::Worker

  def perform
    Rental.send_rental_expiration_notifications
  end
end
