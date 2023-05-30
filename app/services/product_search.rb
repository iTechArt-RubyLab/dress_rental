class ProductSearch < Patterns::Service
  def initialize(query:)
    @query = query
  end

  def call
    Product.where("name LIKE :query OR description LIKE :query", query: "%#{@query}%")
  end
end