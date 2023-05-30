module Admin
  class SalonsController < AdminController
    before_action :set_salon, only: %i[edit update destroy]

    def new
      @salon = Salon.new
    end

    def create
      @salon = Salon.new(salon_params)

      if @salon.save
        redirect_to salon_path(@salon), notice: 'Salon was successfully created.' 
      else
        render :new, status: :unprocessable_entity 
      end
    end

    def edit; end

    def update
      if @salon.update(salon_params)
        redirect_to salon_path(@salon), notice: 'Salon was successfully updated.' 
      else
        render :edit, alert: 'Something went wrong. Please try again.' 
      end
    end

    def destroy
      return unless @salon.destroy

      redirect_to salons_path, notice: 'Salon was successfully destroyed.' 
    end

    private

    def set_salon
      @salon = Salon.find(params[:id])
    end

    def salon_params
      params.require(:salon).permit(:name, :description, :owner_id)
    end
  end
end
