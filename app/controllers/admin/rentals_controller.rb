module Admin
  class RentalsController < AdminController
    before_action :set_rental, only: %i[show update destroy]

    def index
      @rentals = Rental.all
    end

    def new
      @rental = Rental.new
    end

    def show; end

    def create
      @rental = current_user.rentals.new(rental_params)
      if @rental.save
        redirect_to @rental
      else
        redirect_to new_rental_path
        flash[:alert] = @rental.errors.full_messages.join("\n")
      end
    end

    def edit
      @rental = Rental.find(params[:id])
    end

    def update
      @rental.assign_attributes(rental_params)
      if @rental.update(rental_params)
        redirect_to @rental
      else
        redirect_to edit_rental_path
        flash[:alert] = @rental.errors.full_messages.join("\n")
      end
    end

    def destroy
      @rental.destroy
      respond_to do |format|
        format.html { redirect_to admin_rentals_path, notice: 'Rental was successfully destroyed' }
      end
    end

    private

    def set_rental
      @rental = Rental.find(params[:id])
    end

    def rental_params
      params.require(:rental).permit(:start_date, :end_date, :product_id)
    end
  end
end
