class CategoriesController < ApplicationController

  def index
    @categories = Category.all
    # @products = @categories.products.all
  end

  def show
    @category = Category.find(params[:id])
  end
end