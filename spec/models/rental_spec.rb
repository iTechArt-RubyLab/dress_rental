require 'rails_helper'

RSpec.describe Rental, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:product) { FactoryBot.create(:product) }
  
  describe 'validations' do
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }

    context 'when start date is not less than or equal to end date' do
      let(:rental) { FactoryBot.build(:rental, start_date: Date.tomorrow, end_date: Date.today) }
      
      it 'is not valid' do
        expect(rental).to_not be_valid
      end

      it 'has an error message' do
        rental.valid?
        expect(rental.errors[:start_date]).to include("must be less than or equal to #{rental.end_date}")
      end
    end
    
    context 'when end date is not greater than or equal to start date' do
      let(:rental) { FactoryBot.build(:rental, start_date: Date.today, end_date: Date.yesterday) }
      
      it 'is not valid' do
        expect(rental).to_not be_valid
      end

      it 'has an error message' do
        rental.valid?
        expect(rental.errors[:end_date]).to include("must be greater than or equal to #{rental.start_date}")
      end
    end

    context 'when the product is unavailable' do
      let!(:existing_rental) { FactoryBot.create(:rental, product: product, start_date: Date.today + 2, end_date: Date.today + 4) }
      let(:rental) { FactoryBot.build(:rental, product: product, start_date: Date.today + 3, end_date: Date.today + 5) }
      
      it 'is not valid' do
        expect(rental).to_not be_valid
      end

      it 'has an error message' do
        rental.valid?
        expect(rental.errors[:base]).to include("Product with code #{product.id} is already booked for this period")
      end
    end
  end

  describe '#expired?' do
    let(:active_rental) { FactoryBot.create(:rental, product: product, start_date: Date.today, end_date: Date.tomorrow) }
    let(:archived_rental) { FactoryBot.create(:rental, :archived, product: product, start_date: Date.today - 2, end_date: Date.yesterday) }

    it 'returns false for an active rental' do
      expect(active_rental.expired?).to be_falsey
    end

    it 'returns true for an archived rental' do
      expect(archived_rental.expired?).to be_truthy
    end
  end

  describe '#calculate_total_price' do
    let(:rental) { FactoryBot.build(:rental, product: product, start_date: Date.today, end_date: Date.today + 2) }

    it 'sets the total price attribute' do
      rental.valid?
      expect(rental.total_price).to eq(product.price * 3)
    end
  end

  describe '#generate_confirmation_token' do
    let(:rental) { FactoryBot.build(:rental) }

    it 'sets the confirmation token attribute' do
      rental.valid?
      expect(rental.confirmation_token).to_not be_nil
    end
  end
end