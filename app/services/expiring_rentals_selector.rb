class ExpiringRentalsSelector < Patterns::Service
  def call
    Rental.where('end_date BETWEEN ? AND ?', Time.zone.today, 5.days.from_now.to_date).where(status: :confirmed).to_a
  end
end
