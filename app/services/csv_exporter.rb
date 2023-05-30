require 'csv'
class CsvExporter < Patterns::Service
  def self.call(rentals)
    CSV.generate do |csv|
      csv << ['Product name', 'Month', 'Total price ($)', 'Average duration (days)']

      rentals_by_month = rentals.group_by { |r| [r.product.name, r.start_date.month] }
      rentals_by_month.each do |(product_name, month), list|
        total_price = list.sum(&:total_price)
        average_duration = list.sum { |r| (r.end_date - r.start_date).to_i } / list.count
        csv << [product_name, month, total_price, average_duration]
      end
    end
  end
end
