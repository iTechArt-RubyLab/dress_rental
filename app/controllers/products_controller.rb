class ProductsController < ApplicationController
  before_action :set_product, only: %i[show]

  def index
    @products = Product.all
  end

  def show; end

  def search
    @products = ProductSearch.call(query: params[:query]).result.to_a
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end
