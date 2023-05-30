require 'rails_helper'
RSpec.describe Product, type: :model do
  subject { create(:product) }

  describe 'associations' do
    it { should belong_to(:salon) }
    it { should have_many(:product_categories).dependent(:destroy) }
    it { should have_many(:categories) }
    it { should have_many(:rentals).dependent(:destroy) }
    it { should have_many(:users).through(:rentals) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:description) }
  end

  describe '#photo_url' do
    let(:product) { create(:product) }

    context 'with attached photo' do
      before { product.photo.attach(io: File.open(Rails.root.join('spec/fixtures/test.png')), filename: 'test.png') }

      it 'returns the processed photo variant url' do
        expect(product.photo_url).to match(%r{/rails/active_storage/representations/.+/test.png})
      end
    end

    context 'without attached photo' do
      it 'returns the default photo url' do
        expect(product.photo_url).to eq(Product::DEFAULT_PHOTO_URL)
      end
    end
  end
end
