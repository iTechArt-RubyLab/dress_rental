class SalonsController < ApplicationController
  before_action :set_salon, only: %i[show]

  def index
    @salons = Salon.all
  end

  def show
    @products = @salon.products
  end

  private

  def set_salon
    @salon = Salon.find(params[:id])
  end
end
