require 'rails_helper'

RSpec.describe ExpiringRentalsSelector, type: :service do
  describe "#call" do
    it "returns expected rentals" do
      expected_rentals = create_list(:rental, 3, end_date: 5.days.from_now.to_date, status: :confirmed)
      create_list(:rental, 2, end_date: 6.days.from_now.to_date, status: :confirmed)
      create_list(:rental, 4, end_date: 4.days.from_now.to_date, status: :confirmed)
      create_list(:rental, 1, end_date: 5.days.from_now.to_date, status: :canceled)

      expect(subject.call).to match_array(expected_rentals)
    end
  end
end