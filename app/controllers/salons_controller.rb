class SalonsController < ApplicationController
  def index
    @salons = Salon.all
  end

  def show
    @salon = Salon.find(params[:id])
    @products = @salon.products
  end
end
