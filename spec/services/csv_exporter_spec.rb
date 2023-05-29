require 'rails_helper'

RSpec.describe CsvExporter, type: :service do
  describe ".call" do
    let(:rentals) { create_list(:rental, 3) }
    
    it "exports correct CSV data" do
      csv_output = described_class.call(rentals)
      expected_output = "Product name,Month,Total price ($),Average duration (days)\n#{rentals.map { |r| "#{r.product.name},#{r.start_date.month},#{r.total_price},#{(r.end_date - r.start_date).to_i}" }.join("\n")}\n"
      
      expect(csv_output).to eq(expected_output)
    end
  end
end