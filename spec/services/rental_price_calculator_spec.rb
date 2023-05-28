require 'rails_helper'

RSpec.describe RentalPriceCalculator, type: :service do
  let(:start_date) { 10.days.ago.to_date }
  let(:end_date) { 5.days.ago.to_date }
  let(:product_price) { 100 }
  subject { described_class.new(start_date: start_date, end_date: end_date, product_price: product_price) }

  describe "#call" do
    it "calculates rental price correctly" do
      expected_price = (end_date - start_date + 1).to_i * product_price

      expect(subject.call).to eq(expected_price)
    end
  end
end