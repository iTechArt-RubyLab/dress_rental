class ExpiringRentalsSelector < Patterns::Service

  def call
    select_expiring_rentals
  end

  private

  def select_expiring_rentals
    rentals = Rental.where('end_date BETWEEN ? AND ?', Time.zone.today, 5.days.from_now.to_date).where(status: :confirmed).to_a
  end
end