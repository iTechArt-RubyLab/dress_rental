module Admin
  class ProductsController < AdminController
    before_action :set_product, only: %i[edit update destroy]
    before_action :set_salon, only: %i[new create]

    def new
      @product = @salon.products.build
    end

    def edit; end

    def create
      @product = @salon.products.build(product_params)

      if @product.save
        redirect_to products_path, notice: 'Product was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @product.update(product_params)
        redirect_to products_path, notice: 'Product was successfully updated.'
      else
        render :edit, alert: 'There was an error while updating the product.'
      end
    end

    def destroy
      return unless @product.destroy

      redirect_to products_path, notice: 'Product was successfully destroyed.'
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
