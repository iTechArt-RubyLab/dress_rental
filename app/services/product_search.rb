class ProductSearch < Patterns::Service
  def initialize(query:)
    @query = query
  end

  def call
    Product.where("name LIKE ?", "%#{@query}%")
  end
end