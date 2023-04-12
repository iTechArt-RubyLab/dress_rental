class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = 'Category added!'
      redirect_to admin_categories_path
    else
      flash[:notice] = 'An error has occured! Please, try again.'
      render 'admin/products/new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = 'Category updated!'
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    Category.destroy(params[:id])
    flash[:notice] = 'Category deleted!'
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
  
end