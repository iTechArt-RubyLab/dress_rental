require 'sidekiq-scheduler'
class ExpiredRentalsArchiverWorker
  include Sidekiq::Worker

  def perform
    expired_rentals = Rental.where('end_date < ?', Time.zone.today).where.not(status: :archived)
    expired_rentals.each do |rental|
      rental.archived!
      RentalRatingRequestWorker.perform_async(rental.id)
    end
  end
end
