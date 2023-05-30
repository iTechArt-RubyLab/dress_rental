require 'rails_helper'

RSpec.describe Rental, type: :model do
  let(:user) { create(:user) }
  let(:product) { create(:product) }
  let(:rental) { create(:rental, user:, product:) }

  describe 'validations' do
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
    it { should validate_presence_of(:product_id) }
    it { should validate_presence_of(:user_id) }

    it 'validates start_date is less than or equal to end_date' do
      rental.end_date = Date.yesterday
      expect(rental).not_to be_valid
      expect(rental.errors[:start_date]).to include("must be less than or equal to #{rental.end_date}")
    end

    it 'validates end_date is greater than or equal to start_date' do
      rental.start_date = rental.end_date + 1.day
      expect(rental).not_to be_valid
      expect(rental.errors[:end_date]).to include("must be greater than or equal to #{rental.start_date}")
    end

    it 'validates product availability' do
      rental.save
      rental2 = build(:rental, user:, product:, start_date: rental.start_date + 1.day,
                               end_date: rental.end_date - 1.day)
      expect(rental2).not_to be_valid
      expect(rental2.errors[:base]).to include("Product with code #{product.id} is already booked for this period")
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:product) }
  end

  describe 'callbacks' do
    it 'generates a confirmation token before validation' do
      rental.save
      expect(rental.confirmation_token).not_to be_nil
    end

    it 'calculates total price before validation' do
      rental.save
      expect(rental.total_price).to eq(RentalPriceCalculator.call(start_date:, end_date:,
                                                                  product_price: product.price).result)
    end
  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values(unconfirmed: 1, confirmed: 2, archived: 3) }
  end

  describe 'scopes' do
    describe '.rated_by_users_rentals' do
      let(:product2) { create(:product) }
      let!(:rental2) { create(:rental, product: product2, user_rating: 4) }
      let!(:rental3) { create(:rental, product: product2, user_rating: nil) }
      let!(:rental4) { create(:rental, product:, user_rating: 3) }

      it 'returns rentals of products with specified ids that have user ratings' do
        expect(Rental.rated_by_users_rentals([product.id, product2.id])).to match_array([rental2, rental4])
      end

      it 'does not return rentals with nil user ratings' do
        expect(Rental.rated_by_users_rentals([product.id, product2.id])).not_to include(rental3)
      end
    end

    describe '.rated_by_owners_rentals' do
      let!(:rental2) { create(:rental, salon_rating: 4) }
      let!(:rental3) { create(:rental, salon_rating: nil, status: :archived) }
      let!(:rental4) { create(:rental, salon_rating: 3, status: :confirmed) }

      it 'returns rentals with salon ratings' do
        expect(Rental.rated_by_owners_rentals).to match_array([rental2, rental4])
      end

      it 'does not return archived rentals' do
        expect(Rental.rated_by_owners_rentals).not_to include(rental3)
      end

      it 'does not return rentals without salon ratings' do
        expect(Rental.rated_by_owners_rentals).not_to include(rental4)
      end
    end
  end

  describe '#expired?' do
    it 'returns true for rentals with end_date earlier than today' do
      rental.end_date = Date.yesterday
      expect(rental.expired?).to be_truthy
    end

    it 'returns false for rentals with end_date later than today' do
      rental.end_date = Date.tomorrow
      expect(rental.expired?).to be_falsey
    end
  end
end
