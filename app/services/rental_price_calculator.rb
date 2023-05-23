class RentalPriceCalculator < Patterns::Service
  def initialize(start_date:, end_date:, product_price:)
    @start_date = start_date
    @end_date = end_date
    @product_price = product_price
  end

  def call
    (@end_date - @start_date + 1).to_i * @product_price
  end
end
