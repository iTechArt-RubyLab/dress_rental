class RentalsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create], notice: 'You must sign in first!'

  def new
    @rental = Rental.new
  end

  def show
    @rental = Rental.find_by_id(params[:id])
  end

  def create
    @rental = Rental.new(rental_params.merge(user_id: current_user.id))
    @product = @rental.product
    if @rental.valid? && @rental.valid_date && @rental.duplicate_rental != true
      @rental.save
      redirect_to @rental
    else
      if !@rental.valid_date
        flash[:message] = 'Invalid dates selected! Please, check the dates and try again.'
      elsif @rental.duplicate_rental
        flash[:message] = @rental.return_available_dates
      end
      redirect_to new_rental_path
    end
  end

  def edit
    @rental = Rental.find_by_id(params[:id])
    @user = User.find_by_id(params[:id])
  end

  def update
    @rental = Rental.find_by_id(params[:id])
    @rental.assign_attributes(rental_params)
    if @rental.valid? && @rental.valid_date && @rental.duplicate_rental != true
      @rental.save
      redirect_to @rental
    else
      if !@rental.valid_date
        flash[:message] = "Check your dates and try again!"
      elsif @rental.duplicate_rental
        flash[:message] = @rental.return_available_dates
      end
      redirect_to edit_rental_path
    end
  end

  def destroy
    @rental = Rental.find_by_id(params[:id])
    @rental.destroy
    redirect_to root_path
  end

  private

  def rental_params
    params.require(:rental).permit(:start_date, :end_date, :product_id)
  end
end