require 'rails_helper'
RSpec.describe ProductSearch, type: :service do
  describe '#call' do
    it 'returns all products matching the search query' do
      product1 = create(:product, name: 'Lorem ipsum dolor sit amet')
      product2 = create(:product, name: 'Consectetur adipiscing elit')
      product3 = create(:product, name: 'Nam vel dolor quis nunc aliquet')
      search_query = 'dolor'
      result = ProductSearch.call(query: search_query)
      expect(result).to include(product1, product3)
      expect(result).not_to include(product2)
    end

    it 'returns an empty array when there are no matches' do
      create(:product, name: 'Aenean euismod mi ligula')
      search_query = 'nonexistent query'
      result = ProductSearch.call(query: search_query)
      expect(result).to eq([])
    end
  end
end
