require 'rails_helper'
RSpec.describe Salon, type: :model do
  subject { create(:salon) }

  describe 'associations' do
    it { should have_many(:products).dependent(:destroy) }
    it { should have_many(:comments) }
    it { should belong_to(:owner).class_name('User') }
  end

  describe '#update_salon_rating' do
    let(:salon) { create(:salon_with_products) }

    context 'with rated rentals' do
      let!(:rentals) { create_list(:rental, 3, product: salon.products.sample, user_rating: 4) }

      it 'updates the salon rating' do
        expect { salon.update_salon_rating }.to change { salon.reload.rating }.from(nil).to(4.0)
      end
    end

    context 'without rated rentals' do
      it 'sets the salon rating to nil' do
        salon.update_salon_rating
        expect(salon.reload.rating).to be_nil
      end
    end
  end
end