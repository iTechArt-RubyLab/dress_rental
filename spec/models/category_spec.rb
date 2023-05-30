require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { create(:category) }

  it 'is valid with valid attributes' do
    expect(category).to be_valid
  end

  it 'is not valid without a name' do
    category.name = nil
    expect(category).not_to be_valid
  end

  it 'has many product categories' do
    product_category1 = create(:product_category, category:)
    product_category2 = create(:product_category, category:)
    expect(category.product_categories.count).to eq(2)
  end

  it 'has many products' do
    product_category1 = create(:product_category, category:)
    product_category2 = create(:product_category, category:)
    expect(category.products.count).to eq(2)
  end
end
