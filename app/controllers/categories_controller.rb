class CategoriesController < ApplicationController

  def show
    @categories = Category.all
    # @products = @categories.products.all
  end
end