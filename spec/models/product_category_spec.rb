require 'rails_helper'

RSpec.describe ProductCategory, type: :model do
  let(:product_category) { create(:product_category) }

  it 'is valid with valid attributes' do
    expect(product_category).to be_valid
  end

  it 'is not valid without a product' do
    product_category.product = nil
    expect(product_category).not_to be_valid
  end

  it 'is not valid without a category' do
    product_category.category = nil
    expect(product_category).not_to be_valid
  end
end
