require 'sidekiq-scheduler'
class ExpiredRentalsArchiverWorker
  include Sidekiq::Worker

  def perform
    expired_rentals = Rental.where("end_date < ?", Date.today).where.not(status: :archived)
    expired_rentals.update_all(status: :archived)
    expired_rentals.each do |rental|
      RentalRatingRequestWorker.perform_async(rental.id)
    end
  end
end