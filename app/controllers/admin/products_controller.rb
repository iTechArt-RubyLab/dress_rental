module Admin
  class ProductsController < AdminController
    before_action :set_product, only: %i[show edit update destroy]
    before_action :set_salon, only: %i[new create]

    def new
      @product = @salon.products.build
    end

    def edit; end

    def create
      @product = @salon.products.build(product_params)
      @product.salon = @salon

      respond_to do |format|
        if @product.save
          format.html { redirect_to product_url(@product), notice: 'Product was successfully created.' }
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @product.update(product_params)
          format.html { redirect_to product_url(@product), notice: 'Product was successfully updated.' }
        else
          format.html do
            redirect_to edit_admin_product_path(@product), alert: 'There was an error while updating the product.'
          end
        end
      end
    end

    def destroy
      return unless @product.destroy

      respond_to do |format|
        format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      end
    end

    private

    def set_product
      @product = Product.find(params[:id])
    end

    def set_salon
      @salon = Salon.find(params[:salon_id])
    end

    def product_params
      params.require(:product).permit(:name, :price, :description, :photo)
    end
  end
end
