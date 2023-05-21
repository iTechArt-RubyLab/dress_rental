require 'csv'
class CsvExporter < Patterns::Service
  def self.call(rentals)
    CSV.generate do |csv|
      csv << ['ID', 'Start date', 'End date', 'Product name', 'Customer email', 'Rental status', 'Total price, $']
  
      rentals.each do |rental|
        csv << [rental.id, rental.start_date, rental.end_date, rental.product.name, rental.user.email, rental.status, rental.total_price]
      end
    end
  end
end
